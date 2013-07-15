#= require 'sx'

Sx.I18n =
  # ported from rails's date helper distance_of_time_in_words
  timeDistanceInWords: (fromTime, toTime = new Date()) ->
    distanceInMinutes = Math.round(Math.abs((toTime - fromTime) / 60 / 1000))

    if (distanceInMinutes >= 0 && distanceInMinutes <= 1)
      if distanceInMinutes == 0
        I18n.t "datetime.distance_in_words.less_than_x_minutes", count: 1
      else
        I18n.t "datetime.distance_in_words.x_minutes", count: distanceInMinutes
    else if (distanceInMinutes >= 2 && distanceInMinutes <= 44)
      I18n.t "datetime.distance_in_words.x_minutes", count: distanceInMinutes
    else if (distanceInMinutes >= 45 && distanceInMinutes <= 89)
      I18n.t "datetime.distance_in_words.about_x_hours", count:   1
    else if (distanceInMinutes >= 90 && distanceInMinutes <= 1439)
      I18n.t "datetime.distance_in_words.about_x_hours",
        count: Math.round(distanceInMinutes / 60.0)
    else if (distanceInMinutes >= 1440 && distanceInMinutes <= 2519)
      I18n.t "datetime.distance_in_words.x_days", count: 1
    else if (distanceInMinutes >= 2520 && distanceInMinutes <= 43199)
      I18n.t "datetime.distance_in_words.x_days",
        count: Math.round(distanceInMinutes / 1440.0)
    else if (distanceInMinutes >= 43200 && distanceInMinutes <= 86399)
      I18n.t "datetime.distance_in_words.about_x_months", count: 1
    else if (distanceInMinutes >= 86400 && distanceInMinutes <= 525599)
      I18n.t "datetime.distance_in_words.x_months",
        count: Math.round(distanceInMinutes / 43200.0)
    else
      fyear = fromTime.getFullYear()
      tyear = toTime.getFullYear()
      remainder = (distanceInMinutes % 525600)
      distanceInYears = Math.floor(distanceInMinutes / 525600)

      fyear++ if (fromTime.getMonth() + 1) >= 3
      tyear-- if (toTime.getMonth() + 1) < 3

      if (remainder < 131400)
        I18n.t "datetime.distance_in_words.about_x_years",
          count: distanceInYears
      else if (remainder < 394200)
        I18n.t "datetime.distance_in_words.over_x_years",
          count: distanceInYears
      else
        I18n.t "datetime.distance_in_words.almost_x_years",
          count: distanceInYears + 1
