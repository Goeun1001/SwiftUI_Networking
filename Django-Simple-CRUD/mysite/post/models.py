from django.db import models


class Post(models.Model):
    id = models.AutoField
    title = models.CharField(max_length=20)
    content = models.CharField(max_length=100)
    imagePath = models.CharField(max_length=100)

    def __str__(self):
        return self.title
