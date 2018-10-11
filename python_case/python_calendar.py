# python_calendar.py
import calendar

print "calendar.firstweekday()",calendar.firstweekday()
print "calendar.month()",calendar.month(2018,2)
print "calendar.calendar",calendar.calendar(2018, w=2, l=1, c=6, m=3)
print "calendar.day_name",calendar.day_name

print "calendar.prcal(year, w=0, l=0, c=6, m=3)",calendar.prcal(2018, w=0, l=0, c=6, m=3)
print "calendar.day_abbr",calendar.day_abbr