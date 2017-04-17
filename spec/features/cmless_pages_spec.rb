require 'rails_helper'
require 'support/cmless_testing_goodies.rb'


describe 'Cmless' do

  # Add any other Cmless classes to the @cmless_classes array.
  # Tests within the @cmless_class.each loop should be generic enough for each
  # class.
  @cmless_classes = [About, Collection]

  @cmless_classes.each do |klass|

    # In the contet of a given class that inherits from Cmless...
    context "class #{klass}" do

      # Add the special methods used for testing Cmless classes.
      # klass.include CmlessTestingGoodies
      # CmlessTestingGoodies.add_to(klass)
      klass.send(:include, CmlessTestingGoodies)

      # For each pages for the given Cmless class...
      klass.all.each do |cmless_page|

        # In the contest of a given Cmless page instance...
        context "page \"#{cmless_page.title}\"" do

          # For each link within a given Cmless page instance...
          cmless_page.__test.external_links.each do |link|

            # In the context of a link within a Cmless page instance...
            context "with external link \"#{link}\"" do
              
              it "is a working link" do
                expect(link).to be_a_working_link    
              end
            end
          end
        end
      end
    end
  end
end