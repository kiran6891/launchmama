from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def api_router(request,device_type="i",app_version=1,operation="ping"):
    mod = __import__("api.api_version" + str(app_version),globals(),locals(),["ApiVersion" + str(app_version)])
    version_class = getattr(mod, "ApiVersion" + str(app_version))
    return getattr(version_class(), operation)(request, device_type)