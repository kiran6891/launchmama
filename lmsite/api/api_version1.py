import json
from lm.models import QRDetails
from lm.models import ApiOfferDetails
from django.http.response import HttpResponse
import pyqrcode
import uuid


class ApiVersion1():

    def __init__(self):
        pass

    @staticmethod
    def get_qr_details(request, device_type):
        try:
            params = request.POST.get("params",None)
            args = json.loads(params)
            device_id = args["device_id"]
            api_key = args["api_key"]

            # device_id = 123
            # api_key = 123

            response_obj = {}

            # generate qr guid and qr image url
            qr_guid = uuid.uuid1()
            big_code = pyqrcode.create(qr_guid, error='L', version=27, mode='binary')
            image_url = u"{0}qr/{1}.png".format("site_media/media/", qr_guid)
            print image_url
            big_code.png(image_url, scale=6, module_color=[0, 0, 0, 128], background=[0xff, 0xff, 0xcc])

            # save in QRDetails
            try:
                QRDetails.objects.get(device_id=device_id, api_key=api_key)
                response_obj['status'] = "400"
                response_obj['message'] = "QR ALREADY EXISTS"
            except QRDetails.DoesNotExist:

                # select a random offer
                api_offers = ApiOfferDetails.objects.filter(api_key=api_key, remaining_units__gt=0)
                if len(api_offers) > 0:
                    api_offer = api_offers[0]

                    qr = QRDetails.objects.create(qr_guid=qr_guid, image_url=image_url, device_id=device_id,
                                                  api_key=api_key, offer=api_offer.offer)
                    qr.save()

                    response_obj['status'] = "200"
                    response_obj['message'] = "SUCCESS"
                    response_obj['offer_name'] = api_offer.offer.name
                    response_obj['qr_image_url'] = image_url
                    response_obj['qr_id'] = qr.id
                    api_offer.remaining_units -= 1
                    api_offer.save()

            print response_obj
            return HttpResponse(content_type="application/json", content=json.dumps(response_obj))

        except Exception as e:
            print e


    @staticmethod
    def verify_qr_code(request, device_type):
        try:
            # params = request.POST.get("params",None)
            # args = json.loads(params)
            # qr_id = args["qr_id"]
            qr_id = 6
            response_obj = {}
            try:
                qr = QRDetails.objects.get(id=qr_id)
                if qr.is_used:
                    response_obj['status'] = "400"
                    response_obj['message'] = "USED QR"
                else:
                    response_obj['status'] = "200"
                    response_obj['message'] = "SUCCESS"
                    response_obj['offer_name'] = qr.offer.name
                    qr.is_used = True
                    qr.save()

            except QRDetails.DoesNotExist:
                response_obj['status'] = "400"
                response_obj['message'] = "QR ALREADY EXISTS"

            print response_obj
            return HttpResponse(content_type="application/json", content=json.dumps(response_obj))

        except Exception as e:
            print e