# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('lm', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='offer',
            name='is_custom_offer',
            field=models.BooleanField(default=False),
        ),
    ]
