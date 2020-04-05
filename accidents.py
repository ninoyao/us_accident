import streamlit as st;
import pandas as pd;
import numpy as np;
import altair as alt;
import pydeck as pdk;
import matplotlib.pyplot as plt;
import plotly.figure_factory as ff;

import pymysql;
#@st.cache(persist = True)



st.title("Accidents dataset by Kaggle")
st.markdown(
"""
We took a subset of data from the accidents dataset by kaggle. Due to limited processing power of our computers we decided not to use all of the dataset due to time constraint. The full dataset can be found here: https://www.kaggle.com/sobhanmoosavi/us-accidents
""")
st.markdown('<hr>',unsafe_allow_html=True)

@st.cache(persist = True,
allow_output_mutation=True)
def fetch_clean1(localhostname,user,pw,db,port,table):
    conn = pymysql.connect(localhostname,user,pw,db,port)
    cursor = conn.cursor()

    #accidents data
    cursor.execute(f'SELECT * FROM {table}')
    desc = cursor.description
    data = cursor.fetchall()

    data_names = []
    for i in range(len(desc)):
        data_names.append(desc[i][0])

    data_df = pd.DataFrame(data, columns = data_names)
    conn.close()
    return data_df

acc_df= fetch_clean1(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='Accidents')

acc_df = pd.DataFrame(acc_df)
acc_df_1k = st.dataframe(acc_df.iloc[:1000,:])
'accidents_df', acc_df_1k

st.markdown('<hr>',unsafe_allow_html=True)

st.subheader("Distribution of severity of crashes")
plt.hist(acc_df['severity'])
st.pyplot()

st.markdown('<hr>',unsafe_allow_html=True)

st.subheader("Number of crashes during the day and night")
plt.hist(acc_df['sunrise_sunset'])
st.pyplot()

st.markdown('<hr>',unsafe_allow_html=True)

env_df= fetch_clean1(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='Environment')

env_df_1k = st.dataframe(env_df.iloc[:1000,:])
'environment_df', env_df_1k

st.markdown('<hr>',unsafe_allow_html=True)

st.subheader("Distribution of crashes by weather conditions")
plt.hist(env_df['weather_condition'].groupby('weather_condition').value_counts())
#plt.hist(env_df['weather_condition'],align = 'mid', orientation ='vertical')
st.pyplot()

#temp = env_df['temperature']
#hum = env_df['humidity']
#pres = env_df['pressure']
#vis = env_df['visibility']
#ws = env_df['wind_speed']
#hist_data = [temp, hum, pres,vis,ws]
#env_label = ['temperature','humidity','pressure','visibility','wind_speed']
#fig = ff.create_distplot(hist_data, env_label)
#fig = ff.create_distplot(env_df['temperature'])
#st.plotly_chart(fig, use_container_width=True)
#st.markdown('<hr>',unsafe_allow_html=True)

loc_df= fetch_clean1(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='Location_POI_start')



loc_df_1k = st.dataframe(loc_df.iloc[:1000,:])
'loc_df', loc_df_1k

st.markdown('<hr>',unsafe_allow_html=True)

zip_df= fetch_clean1(localhostname='localhost',
             user='root',
             pw='root',
             db='accidents2',
             port=8889,
             table='Location_zip')

zip_df_1k = st.dataframe(zip_df.iloc[:1000,:])
'zip_df', zip_df_1k

st.markdown('<hr>',unsafe_allow_html=True)

st.subheader("Number of crashes by timezone")
plt.hist(zip_df['timezone'])
st.pyplot()