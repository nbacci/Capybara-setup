require 'rails_helper'

feature "Events" do
  #Create
  scenario "User can create an event" do
    visit root_path
    click_on "New Event"
    fill_in "Description", with: "My awesome event"
    click_on "Create Event"

    expect(page).to have_content("My awesome event")
  end

  #Edit
  scenario "User edits an event" do
    Event.create!(
      description: "My aweeesome event"
    )

    visit root_path
    expect(page).to have_content("My aweeesome event")
    click_on "edit"
    fill_in "Description", with: "My awesome event"
    click_on "Update Event"

    expect(page).to have_content("My awesome event")
    expect(page).to have_no_content("My aweeesome event")
  end

  #Read/Show
  scenario 'listing events' do
    Event.create!(
      description: "Free lunch today - oh and a gschool panel",
    )

    Event.create!(
      description: "Hug Momo Hour",
    )

    Event.create!(
      description: "Ramen festival",
    )

    visit root_path

    expect(page).to have_content("Free lunch today")
    expect(page).to have_content("Hug Momo Hour")
    expect(page).to have_content("Ramen festival")
  end

  #Delete
  scenario 'deleting events' do
    Event.create!(
      description: "Im going to be deleted"
    )

    visit root_path
    click_on "delete"

    expect(page).to have_no_content("Im going to be deleted")
    expect(page.current_path).to eq(events_path)
  end
end
