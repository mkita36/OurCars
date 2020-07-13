require "application_system_test_case"

class Manager::InspectionsTest < ApplicationSystemTestCase
  setup do
    @manager_inspection = manager_inspections(:one)
  end

  test "visiting the index" do
    visit manager_inspections_url
    assert_selector "h1", text: "Manager/Inspections"
  end

  test "creating a Inspection" do
    visit manager_inspections_url
    click_on "New Manager/Inspection"

    fill_in "Car", with: @manager_inspection.car_id
    fill_in "Fee", with: @manager_inspection.fee
    fill_in "Inspection day", with: @manager_inspection.inspection_day
    fill_in "Limit", with: @manager_inspection.limit
    click_on "Create Inspection"

    assert_text "Inspection was successfully created"
    click_on "Back"
  end

  test "updating a Inspection" do
    visit manager_inspections_url
    click_on "Edit", match: :first

    fill_in "Car", with: @manager_inspection.car_id
    fill_in "Fee", with: @manager_inspection.fee
    fill_in "Inspection day", with: @manager_inspection.inspection_day
    fill_in "Limit", with: @manager_inspection.limit
    click_on "Update Inspection"

    assert_text "Inspection was successfully updated"
    click_on "Back"
  end

  test "destroying a Inspection" do
    visit manager_inspections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inspection was successfully destroyed"
  end
end
