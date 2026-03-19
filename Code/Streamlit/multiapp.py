import streamlit as st

# Credit to https://github.com/dataprofessor/multi-page-app for multipage functionality

class MultiApp:
    def __init__(self):
        self.apps = []

    def add_app(self, title, function):
        self.apps.append({"title": title, "function": function})
    
    def run(self):
        app = st.selectbox('Navigation', self.apps, format_func=lambda app: app['title'])

        app['function']()