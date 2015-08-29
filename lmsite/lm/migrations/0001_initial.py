# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='ApiOfferDetails',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('api_key', models.CharField(max_length=255)),
                ('remaining_units', models.IntegerField()),
            ],
            options={
                'db_table': 'api_offer_details',
            },
        ),
        migrations.CreateModel(
            name='Offer',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.TextField(null=True, blank=True)),
                ('free_units', models.IntegerField()),
                ('total_cost', models.IntegerField()),
            ],
            options={
                'db_table': 'offer',
            },
        ),
        migrations.CreateModel(
            name='QRDetails',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('qr_guid', models.CharField(max_length=255)),
                ('image_url', models.CharField(max_length=255)),
                ('device_id', models.CharField(max_length=255)),
                ('api_key', models.CharField(max_length=255)),
                ('is_used', models.BooleanField(default=False)),
                ('offer', models.ForeignKey(to='lm.Offer')),
            ],
            options={
                'db_table': 'qr_details',
            },
        ),
        migrations.CreateModel(
            name='UserApiDetails',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('api_key', models.CharField(max_length=255)),
                ('total_amount_paid', models.IntegerField()),
                ('user', models.ForeignKey(to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'user_api_details',
            },
        ),
        migrations.AddField(
            model_name='apiofferdetails',
            name='offer',
            field=models.ForeignKey(to='lm.Offer'),
        ),
    ]
