import streamlit as st
from PIL import Image

def app():
    st.title('Home Screen')
    st.write('This is the Home Screen of our Multi-Page App.')
    st.write('In this app we will be showcasing our Integrated Global Data Dataset!')
    st.write('Lets start with some Exploratory Data Analysis (EDA) using Pandas Proiling for detailed descriptions of the data!')
    st.write('Then we will move onto some visualizations we used!')

    image = Image.open('istockphoto-835833518-170667a.jpg')
    st.image(image, caption='Grains are one of the important food groups!')