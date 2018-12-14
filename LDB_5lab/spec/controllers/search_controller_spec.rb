# frozen_string_literal: true

require_relative '../rails_helper'

describe SearchController do
  let(:all_params) do
    { :proj => 'Project', :wgs => 'WorkGroup', :usr => 'User', 'tsk' => 'Task',
      :note => 'NotesManager', :ordr => 'Order',
      :search => { :value => 'tg@gmail.com' } }
  end
end
