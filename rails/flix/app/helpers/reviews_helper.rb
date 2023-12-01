module ReviewsHelper
  def average_stars(movie)
    average_stars = movie.average_stars
    if average_stars == 0.0
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(average_stars, precision: 1), "star")
    end
  end
end
