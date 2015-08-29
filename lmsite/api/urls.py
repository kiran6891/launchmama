from django.conf.urls import patterns, url

urlpatterns = patterns('api.views',
    url(r'^(?P<device_type>\w)/(?P<app_version>\d)/(?P<operation>\w+)$', 'api_router', name='api_router'),
)