from matplotlib.pyplot import title
import numpy as np
import pandas as pd
import streamlit as st
from pandas_profiling import ProfileReport
from streamlit_pandas_profiling import st_profile_report

# Web Page Title

def app():
    
    st.title('Exploring our Data using Pandas Profiling')

    dataset = st.button('Click here to Load Data: it may take a minute!')

    if dataset:
        @st.cache
        def load_csv():
            csv = pd.read_csv('Real_Final_Integrated_Data.csv')
            return csv

        df = load_csv()
        pr = ProfileReport(df, explorative=True)
        
        st.header('**Integrated DataFrame**')
        st.dataframe(df)
        st.write('---')
        st.header('**Pandas Profiling Report**')
        st_profile_report(pr)
    else:
        st.info('Waiting to show you details about our data.')