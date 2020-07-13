require "application_system_test_case"

class UsesTest < ApplicationSystemTestCase
  setup do
    @use = uses(:one)
  end

  test "visiting the index" do
    visit uses_url
    assert_selector "h1", text: "Uses"
  end

  test "creating a Use" do
    visit uses_url
    click_on "New Use"

    fill_in "Car", with: @use.car_id
    fill_in "Destination", with: @use.destination
    fill_in "Odometer", with: @use.odometer
    fill_in "Oil change", with: @use.oil_change
    fill_in "Refueling amount", with: @use.refueling_amount
    fill_in "Use day", with: @use.use_day
    fill_in "User", with: @use.user_id
    fill_in "Wash", with: @use.wash
    click_on "Create Use"

    assert_text "Use was successfully created"
    click_on "Back"
  end

  test "updating a Use" do
    visit uses_url
    click_on "Edit", match: :first

    fill_in "Car", with: @use.car_id
    fill_in "Destination", with: @use.destination
    fill_in "Odometer", with: @use.odometer
    fill_in "Oil change", with: @use.oil_change
    fill_in "Refueling amount", with: @use.refueling_amount
    fill_in "Use day", with: @use.use_day
    fill_in "User", with: @use.user_id
    fill_in "Wash", with: @use.wash
    click_on "Update Use"

    assert_text "Use was successfully updated"
    click_on "Back"
  end

  test "destroying a Use" do
    visit uses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Use was successfully destroyed"
  end
end
