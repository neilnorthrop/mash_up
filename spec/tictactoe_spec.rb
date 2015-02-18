ENV['RACK_ENV'] = 'test'

require Dir.pwd + '/lib/tictactoe.rb'
require 'spec_helper'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'rack/test'
require 'pp'

def capy_app
  Capybara.app = Sinatra::Application.new
end

RSpec.describe 'when visiting the website' do
  def app
    Sinatra::Application
  end

  it "shows 'Pick your board size and opponent' on the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Pick your board size and opponent:')
  end
end

RSpec.describe 'when player one picks the 3x3 or 4x4 option' do
  capy_app

  it 'shows a 3x3 board' do
    visit '/'
    choose '3x3'
    click_button('Computer')
    expect(page).to have_css('.board')
  end

  it 'shows a 4x4 board' do
    visit '/'
    choose '4x4'
    click_button('Player')
    expect(page).to have_css('.board4x4')
  end
end

RSpec.describe 'when player one picks a cell' do
  capy_app

  it 'posts a move to the game board' do
    visit '/'
    choose '3x3'
    click_button('Computer')
    click_button('1')
    expect(page).to have_css('#cellX')
  end

  it 'has computer take the next turn' do
    visit '/'
    choose '3x3'
    click_button('Computer')
    click_button('1')
    expect(page).to have_css('#cellO')
  end
end

RSpec.describe 'when player one matches three in a row' do
  capy_app

  it 'shows that player was the winner' do
    visit '/'
    choose '3x3'
    click_button('Player')
    click_button('1')
    click_button('2')
    click_button('4')
    click_button('5')
    click_button('7')
    expect(page).to have_content('PLAYER WON!')
  end
end

RSpec.describe 'when computer matches three in a row' do
  capy_app

  it 'shows that computer was the winner' do
    visit '/'
    choose '3x3'
    click_button('Computer')
    click_button('1')
    click_button('2')
    click_button('4')
    expect(page).to have_content('COMPUTER WON!')
  end
end

RSpec.describe 'when there is a winner', js: true do
  capy_app

  it 'disables the buttons' do
    visit '/'
    choose '3x3'
    click_button('Computer')
    click_button('1')
    click_button('2')
    click_button('4')
    expect(page).to have_css('#cell9[disabled]')
  end
end
