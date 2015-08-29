"""lmsite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import include, url, patterns
from django.contrib import admin
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
import settings


urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^login$', "views.do_login", name="do_login"),
    url(r'^home$', "views.home", name="home"),
    url(r'^make-payment$', "views.make_payment", name="make_payment"),
    url(r'^payment-success/(?P<user_api_id>\d+)$', "views.payment_success", name="payment_success"),
    url(r"^api/", include("api.urls")),
    # url(r'$', "views.index", name="index"),
    #url(r'^logout$', "views.do_logout", name="do_logout"),
]


if settings.DEBUG:
    urlpatterns += patterns('',
                            (r'^%s(?P<path>.*)$' % settings.MEDIA_URL[1:],
                             'django.views.static.serve',
                             {'document_root': settings.MEDIA_ROOT, 'show_indexes': True}), )
    urlpatterns += staticfiles_urlpatterns()
