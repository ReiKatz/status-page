# content of test_example.py
from django.test import Client

def test_example():
    client = Client()
    response = client.get('/')
    assert response.status_code == 200
    
