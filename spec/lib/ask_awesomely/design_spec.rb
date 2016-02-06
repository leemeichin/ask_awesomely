require "spec_helper"

describe AskAwesomely::Design, "Creating designs" do

  subject { AskAwesomely::Design }

  describe "the design ID" do
    it "submits a design and comes back with a design ID" do
      VCR.use_cassette("create_design") do
        design = subject.new do
          question_color "#ff3300"
          background_color "#ff0033"
          answer_color "#0033ff"
          button_color "#00ff33"
          font "Arvo"
        end

        design.id.must_equal("5SWktYqkvg")
      end
    end
  end
end
