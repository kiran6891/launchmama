from django.contrib.auth import authenticate, logout
from django.contrib.auth.views import login
from django.core.urlresolvers import reverse
from django.http.response import HttpResponseRedirect, HttpResponse
from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.views.decorators.csrf import csrf_exempt
from lm.models import Offer
from lm.models import UserApiDetails, ApiOfferDetails
import uuid
import json

__author__ = 'kiran'


def index(request):
    if request.user.is_anonymous():
        return HttpResponseRedirect(reverse("do_login"))
    else:
        return HttpResponseRedirect(reverse("home"))


def do_login(request):
    if request.POST:
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(username=username, password=password)
        if user:
            if user.is_active:
                login(request, user)
        return HttpResponseRedirect(reverse("home"))
    return render_to_response(
        "account/login.html",
        {},
        RequestContext(request)
    )


def home(request):
    offer_list = Offer.objects.all()
    context = {
        "offer_list": offer_list
    }
    return render_to_response(
        "home.html",
        context,
        RequestContext(request)
    )


def make_payment(request):
    total_amount = request.POST["total_amount"]
    total_amount = int(total_amount)
    api_key = uuid.uuid1()
    user_api_details = UserApiDetails.objects.create(
        user=request.user,
        api_key=api_key,
        total_amount_paid=total_amount
    )
    user_api_details.save()

    # save in api offer details
    str_offer_id = request.POST["str_offer_id"]
    offer_list = str_offer_id.split(",")
    for offer_id in offer_list:
        offer = Offer.objects.get(id=offer_id)
        ApiOfferDetails.objects.create(api_key=api_key, offer=offer, remaining_units=offer.free_units)

    return HttpResponse(user_api_details.id)


def payment_success(request, user_api_id):
    user_api_details = UserApiDetails.objects.get(id=user_api_id)
    context = {
        "user_api_details": user_api_details
    }
    return render_to_response(
        "payment_success.html",
        context,
        RequestContext(request)
    )


def do_logout(request):
    print "Logout"
    logout(request)
    return HttpResponseRedirect(reverse("index"))