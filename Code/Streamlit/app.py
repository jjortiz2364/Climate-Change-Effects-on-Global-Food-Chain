from matplotlib.pyplot import title
import numpy as np
import pandas as pd
import streamlit as st
from multiapp import MultiApp
from apps import EDA, home_screen, visuals
from pandas_profiling import ProfileReport
from streamlit_pandas_profiling import st_profile_report

st.set_page_config(page_title='Global Country and Food Supply App', layout='wide')
# Web Page Title

app = MultiApp()


app.add_app("Home", home_screen.app)
app.add_app("EDA", EDA.app)
app.add_app("Visualizations", visuals.app)

app.run()



