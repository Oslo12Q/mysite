from django.contrib import admin

from polls.models import Choice, Poll


class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3

class PollAdmin(admin.ModelAdmin):
   
    search_fields = ['question']
    date_hierarchy = 'pub_date' 
    list_filter = ['pub_date']
    list_display = ('question', 'pub_date', 'was_published_recently')
    fieldsets = [
        (None,               {'fields': ['question']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
    ]
    inlines = [ChoiceInline]

admin.site.register(Poll, PollAdmin)

# Register your models here.
