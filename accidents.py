import streamlit as st;
import pandas as pd;
import numpy as np;
import altair as alt;
import pydeck as pdk;
import matplotlib.pyplot as plt;
import plotly.graph_objects as go;
import plotly.express as px;

import pymysql;

import datetime as dt;
#@st.cache(persist = True)



st.title("United States Accident Data")

st.write(
    'The dataset used for this dashboard is United States data that can be found on kaggle. The intended user for this dashboard are researchers and individuals who are interested in learning more about US accident trends. For this demo, data was subsetted from the full dataset by Kaggle to ensure data can be returned quickly from the database!'
)

st.markdown(
    "###### The full US accidents data set can be found here: https://www.kaggle.com/sobhanmoosavi/us-accidents"
)
st.markdown('<hr>',unsafe_allow_html=True)

@st.cache(persist = True,
allow_output_mutation=True)
def query_data(localhostname,user,pw,db,port,table,nrow=0):
    conn = pymysql.connect(localhostname,user,pw,db,port)
    cursor = conn.cursor()

    #accidents data
    cursor.execute(f'SELECT * FROM {table} LIMIT {nrow}')
    desc = cursor.description
    data = cursor.fetchall()

    data_names = []
    for i in range(len(desc)):
        data_names.append(desc[i][0])

    data_df = pd.DataFrame(data, columns = data_names)
    conn.close()
    return data_df



######### QUERYING DATA A###############
st.header("Part 1")
nrow_acc = st.sidebar.slider("PT1: How much data would you like to query? (100-100000)",100,100000,100, step=100)

st.write(
    'In the sidebar, please choose the amount of data you would like to visualize! You can toggle the view of the raw data by checking and unchecking the box below. Once you query the database, the charts will automatically update with the new data!')
st.markdown("###### Since we are using a subset of the total dataset, the visualizations are not a full representation of the data.")

acc_df= query_data(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='Accidents',
             nrow=nrow_acc)
acc_df['start_time']=acc_df['start_time'].dt.normalize()
acc_df['end_time']=acc_df['end_time'].dt.normalize()
acc_df['weather_timestamp']=acc_df['weather_timestamp'].dt.normalize()
acc_df['year'] = pd.DatetimeIndex(acc_df['start_time']).year
acc_df['month'] = pd.DatetimeIndex(acc_df['start_time']).month
c_box = st.checkbox("View Raw Data")
if c_box == True:
    s_acc_df = st.dataframe(acc_df)
    'accidents_df', s_acc_df



######### CREATING SEVERITY BARCHART A###############
severity_bar = acc_df.groupby('severity').count()
severity_bar = severity_bar.reset_index()
severity_bar['severity'] = severity_bar['severity'].astype('category')

sev_fig = px.bar(severity_bar, x="severity", y="id")
sev_fig.update_layout(title='Count of accidents by severity',
                  xaxis_type='category',
                   xaxis_title='Severity Score',
                   yaxis_title='Count')
st.plotly_chart(sev_fig, use_container_width=True)

st.write("Most of the crashes from the dataset have a severity score of 2.")

######### CREATING DAY-NIGHT BARCHART A###############
day_night = pd.DataFrame(acc_df['sunrise_sunset'].value_counts()).reset_index()

df_fig = px.bar(day_night, x="index", y="sunrise_sunset")
df_fig.update_layout(title='Count of accidents by Time of Day',
                  xaxis_type='category',
                   xaxis_title='Time of day',
                   yaxis_title='Count')
st.plotly_chart(df_fig, use_container_width=True)

st.write("As expected many accidents occur during the day. Why is that?")

######### CREATING LINE CHART A###############
d_month_count = acc_df.groupby('month').count()
d_month_count = d_month_count.reset_index()
tseries_fig = px.line(d_month_count, x="month", y="id")
tseries_fig.update_layout(title='Number of Accidents per Month',
                   xaxis_title='Month',
                   yaxis_title='Count')
st.plotly_chart(tseries_fig, use_container_width=True)

st.write("A simple timeseries chart of the crashes per month!")

st.markdown('<hr>',unsafe_allow_html=True)

st.header('Part 2')
st.subheader("Let us look at the data on an aggregated level")
st.write("In the sidebar, please input a numeric value to query from the database.")
nrow_ALZ = st.sidebar.number_input("P2: Please input the amount of data you would like to query. (Max:1000000)",500,1000000,500,step=500, key= "ALZ")

ALZ = query_data(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='accidents_loc_zip',
             nrow=nrow_ALZ)

ALZ['weather_timestamp']=ALZ['weather_timestamp'].dt.normalize()


ALZ_c_box = st.checkbox("View Raw Data",key="env_c_box")
if ALZ_c_box == True:
    s_ALZ = st.dataframe(ALZ)
    'Raw Environment Data', s_ALZ

ALZ['temperature']= ALZ['temperature'].astype(float)
ALZ['humidity']= ALZ['humidity'].astype(float)
ALZ['pressure']= ALZ['pressure'].astype(float)
ALZ['visibility']= ALZ['visibility'].astype(float)
ALZ['wind_speed']= ALZ['wind_speed'].astype(float)

fcs = st.sidebar.radio("PT2: How would you like to group the data?",
        ('city','state','airport_code','timezone','weather_condition'),key='filter_cs')

atype = st.sidebar.radio("PT2: How would you like the data to be aggregated?",
                ("min","max","mean"),key='agg_type')

ftype = st.sidebar.radio("PT2: What type of environmental data would you like to visualize?",
                ("temperature","humidity","pressure","visibility","wind_speed"),key='feat_type')

######### AGGREGATIONS FOR VISUALIZATIONS###############
def filter_plot(cs=fcs,agg=atype,feat=ftype):

    ALZ['temperature']= ALZ['temperature'].astype(float)
    ALZ['humidity']= ALZ['humidity'].astype(float)
    ALZ['pressure']= ALZ['pressure'].astype(float)
    ALZ['visibility']= ALZ['visibility'].astype(float)
    ALZ['wind_speed']= ALZ['wind_speed'].astype(float)
    df = ALZ.groupby(f'{cs}').agg(f'{agg}')
    df=df.reset_index()
    df_fig = px.bar(df, x=f"{cs}", y=f"{feat}")
    df_fig.update_layout(title=f'{agg} {feat} by {cs}',
                   xaxis_title=f'{cs}',
                   yaxis_title=f'{agg} {feat}')
    return st.plotly_chart(df_fig, use_container_width=True)
    
filter_plot(fcs,atype,ftype)
st.markdown('<hr>',unsafe_allow_html=True)

st.header('Part 3.1')
st.write("Let us see how the data looks visually on a map! The data points are located in CA and OH. Feel free to interact with the map by zooming and panning! Hoever over points to get more information")
midpoint = (ALZ['start_lat'].mean(), ALZ['start_lng'].mean())
cols = ['start_lat','start_lng','city','state','temperature','humidity','pressure','visibility','weather_condition','severity','sunrise_sunset','wind_speed']
ALZ_map = ALZ[cols]

col_group = st.sidebar.radio("PT3.1: What group type would you like to color the points by?",
                ("weather_condition","severity","sunrise_sunset","wind_speed"),key='col_group')

def scat_plotly(col_group = col_group):
    fig = px.scatter_mapbox(ALZ_map, lat="start_lat", lon="start_lng", 
                        hover_name="city", 
                        hover_data=["city", "state","temperature","humidity","pressure","visibility","weather_condition"],
                        color = f'{col_group}',
                        color_discrete_sequence=px.colors.sequential.thermal, zoom=3, height=300)
    fig.update_layout(mapbox_style="open-street-map")
    fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
    return st.plotly_chart(fig, use_container_width=True)

scat_plotly(col_group)

st.header('Part 3.2')
den_group = st.sidebar.radio("PT3.2: What group type would you like to color the points by?",
                ("temperature","humidity","pressure","visibility","wind_speed"),key='den_group')
def den_plot(par = den_group):
    fig = px.density_mapbox(ALZ_map, lat='start_lat', 
                        lon='start_lng', 
                        z=f'{par}',
                        radius=10,
                        zoom=3)
    fig.update_layout(mapbox_style="open-street-map")
    fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
    return st.plotly_chart(fig, use_container_width=True)
den_plot(den_group)

st.markdown('<hr>',unsafe_allow_html=True)
st.markdown('##### Authors: Nino Yao & Linh Nguyen')