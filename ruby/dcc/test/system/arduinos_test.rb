require "application_system_test_case"

class ArduinosTest < ApplicationSystemTestCase
  setup do
    @arduino = arduinos(:one)
  end

  test "visiting the index" do
    visit arduinos_url
    assert_selector "h1", text: "Arduinos"
  end

  test "should create arduino" do
    visit arduinos_url
    click_on "New arduino"

    fill_in "Name", with: @arduino.name
    fill_in "Port", with: @arduino.port
    click_on "Create Arduino"

    assert_text "Arduino was successfully created"
    click_on "Back"
  end

  test "should update Arduino" do
    visit arduino_url(@arduino)
    click_on "Edit this arduino", match: :first

    fill_in "Name", with: @arduino.name
    fill_in "Port", with: @arduino.port
    click_on "Update Arduino"

    assert_text "Arduino was successfully updated"
    click_on "Back"
  end

  test "should destroy Arduino" do
    visit arduino_url(@arduino)
    click_on "Destroy this arduino", match: :first

    assert_text "Arduino was successfully destroyed"
  end
end
