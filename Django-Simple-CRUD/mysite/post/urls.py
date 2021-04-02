from django.urls import path
from . import views

app_name = 'Notice'

urlpatterns = [
    path('post', views.post_list),
    path('post/<int:pk>', views.post_detail),
]