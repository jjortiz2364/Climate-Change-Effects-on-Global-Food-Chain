import streamlit as st
st.set_option('deprecation.showPyplotGlobalUse', False)
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import MinMaxScaler

def app():
    @st.cache
    def load_csv():
        csv = pd.read_csv('Real_Final_Integrated_Data.csv')
        return csv
    
    df = load_csv()

    # Separating numeric from categorical
    non_scaled_cols = ['Country','Year', 'ISO_CODE','Longitude','Latitude','Commodity_ID','Commodity_Description']
    data_to_scale = df.drop(non_scaled_cols, axis=1)
    grain_columns = ["Area_Harvested_HA","Beginning_Stocks_MT","Ending_Stocks_MT","Imports_MT","Exports_MT","Feed_Dom_Consumption_MT","FSI_Consumption_MT","Production_MT","TY_Imports_MT",  "TY_Imports_from_US_MT", "TY_Exports_MT", "Milling_Rate_MT", "Rough_Production_MT"]
    scaled_columns = data_to_scale.columns
    encoded_cols = ['Barley', 'Corn', 'Empty', 'Millet', 'Mixed Grain', 'Oats', 'Rice, Milled', 'Rye', 'Sorghum', 'Wheat']

    @st.cache(suppress_st_warning=True)
    def scaling():
        scaler = MinMaxScaler()
        normalized_data = scaler.fit_transform(data_to_scale)
        scaled_data = pd.DataFrame(normalized_data, columns = scaled_columns)
        return scaled_data

    @st.cache(suppress_st_warning=True)
    def encoding_preprocess():
        encoder = OneHotEncoder()
        data_encoded = pd.DataFrame(encoder.fit_transform(df[['Commodity_Description']]).toarray())
        data_encoded.columns = encoded_cols
        data_encoded_final = df.join(data_encoded)
        return data_encoded_final

    #st.write(encoding_preprocess())

    with st.sidebar.header('Please select a Country and Grain Feature'):
        visual_type = st.selectbox('Please Select a Visualization Type', ['Pie Chart', 'Line Graph', 'Scatter Plot'])


    if visual_type == 'Pie Chart':

        countries = df.Country.unique()
        features = grain_columns

        country_chosen = st.selectbox('Select the Country you want to visualize', countries)
        feature_chosen = st.selectbox('Select the Grain Feature to compare grain distribution', features)

        def pie_country(country_chosen, feature_chosen):
            country_data = df[df['Country'] == country_chosen]
            country_data.groupby(['Commodity_Description']).sum().plot(kind='pie', y=feature_chosen, figsize=(5,5))
            plt.title(country_chosen)

        st.pyplot(pie_country(country_chosen, feature_chosen))

    elif visual_type == 'Line Graph':

        countries = df.Country.unique()
        features = scaling()

        country_chosen = st.selectbox('Select the Country you want to visualize', countries)
        feature_chosen = st.selectbox('Select the Scaled Feature to compare against other countries', features.columns)

        def line_graph(country_chosen, feature_chosen):
            fig, ax = plt.subplots(1)
            country_data = df[df['Country'] == country_chosen]
            ax.plot(country_data['Year'], country_data[feature_chosen])
            ax.set_title(country_chosen)
            ax.set_ylim(ymin=0)
            ax.set_xlabel('Year')
            ax.set_ylabel(feature_chosen)

        st.pyplot(line_graph(country_chosen, feature_chosen))

    elif visual_type == 'Scatter Plot':

        features = scaling()

        feature1 = st.selectbox('Select the first Scaled Feature to compare against another Scaled Feature', features.columns.to_list(), key='<0>')
        feature2 = st.selectbox('Select the second Scaled Feature to compare against another Scaled Feature', features.columns.to_list(), key='<0>')

        def scatterplot(feature1, feature2):
            fig, ax = plt.subplots(1)
            ax.scatter(features[str(feature1)], features[str(feature2)])
            ax.set_title(feature1 + ' & ' + feature2)
            ax.set_ylim(ymin=0)
            ax.set_xlabel(feature1)
            ax.set_ylabel(feature2)

        st.pyplot(scatterplot(feature1, feature2))
    
