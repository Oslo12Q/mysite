import datetime

from django.test import TestCase

from django.utils import timezone

from .models import Poll

class PollMethodTests(TestCase):

	def test_was_published_recently_with_old_question(self):
		"""
        	was_published_recently() should return False for questions whose
        	pub_date is in the future.
        	"""
        	time = timezone.now() + datetime.timedelta(days=30)
        	future_question = Poll(pub_date=time)
        	self.assertEqual(future_question.was_published_recently(), False)

	def test_was_published_recently_with_recent_question(self):

		"""
    		was_published_recently() should return True for questions whose
    		pub_date is within the last day.
    		"""
    		time = timezone.now() - datetime.timedelta(hours=1)
    		recent_question = Poll(pub_date=time)
    		self.assertEqual(recent_question.was_published_recently(), True)


class SmokeTest(TestCase):

	def test_bad_maths(self):
		self.assertEqual(1+2,3)
# Create your tests here.
