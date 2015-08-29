from django.contrib.auth.models import User
from django.db import models


class Offer(models.Model):

    # This model stores all the offers available
    # via launchmama

    name = models.CharField(max_length=255)  # name of the offer

    free_units = models.IntegerField()  # free drinks available Eg: 100 free drinks at Brewsky
    total_cost = models.IntegerField()  # Total cost Eg: 100 units * Rs. 300 = Rs. 3000

    def __unicode__(self):
        return self.name

    class Meta:
        db_table = "offer"


class UserApiDetails(models.Model):

    # This models stores all the api keys generated
    # for the user

    user = models.ForeignKey(User)  # The user or the app developer
    api_key = models.CharField(max_length=255)  # The api key generated for the developer
    total_amount_paid = models.IntegerField()  # Total amount paid :)

    def __unicode__(self):
        return u"{0} - {1}".format(self.user.first_name, self.api_key)

    class Meta:
        db_table = "user_api_details"


class ApiOfferDetails(models.Model):

    # This model stores all the offers associated with
    # the api

    api_key = models.CharField(max_length=255)
    offer = models.ForeignKey(Offer)
    remaining_units = models.IntegerField()

    def __unicode__(self):
        return u"{0} - {1}".format(self.api_key, self.offer.name)

    class Meta:
        db_table = "api_offer_details"


class QRDetails(models.Model):

    qr_guid = models.CharField(max_length=255)
    image_url = models.CharField(max_length=255)
    device_id = models.CharField(max_length=255)
    api_key = models.CharField(max_length=255)
    offer = models.ForeignKey(Offer)
    is_used = models.BooleanField(default=False)

    def __unicode__(self):
        return self.image_url

    class Meta:
        db_table = "qr_details"


