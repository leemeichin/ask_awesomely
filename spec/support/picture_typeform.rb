class PictureTypeform
  include AskAwesomely::DSL

  title "Picture Typeform"

  tags "example", "with-picture"

  field :picture_choice do
    ask "Spoon or fork?"

    choice "Spoon", picture: "https://upload.wikimedia.org/wikipedia/commons/9/92/Soup_Spoon.jpg"
    choice "Fork", picture: "https://upload.wikimedia.org/wikipedia/commons/7/7c/Assorted_forks.jpg"
  end

end
