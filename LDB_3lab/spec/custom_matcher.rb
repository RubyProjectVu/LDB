# frozen_string_literal: true

# yaml files have no triple dashes, empty hashes
RSpec::Matchers.define :has_yml_nils do
  match do |actual|
    File.open actual do |file|
      file.find do |line|
        return true if line.match?(/\{\}/) || line.match?(/---/)
      end
    end
    return false
  end
end

# Checks whether the project (by id) has positive budget
RSpec::Matchers.define :project_budget_positive do
  match do |budget|
    file = YAML.load_file('budgets.yml')
    return true if file.fetch(budget).fetch('budget').positive?
    return false
  end
end

# Specified password should have at least a number and a special character
# user_spec.rb::96
RSpec::Matchers.define :has_advanced_password do
  match do |string|
    if string.match?(/\d/)
      return true unless [nil].include?(
        string.index(/[\+\-\!\@\#\$\%\^\&\*\(\)]/)
      )
    end
    return false
  end
end

# A note should not have any bad words entered
# notes_manager_spec::62
RSpec::Matchers.define :has_bad_words do
  match do |text|
    badlist = %w[bad\ word other\ bad\ word really\ bad\ word]
    badlist.any? { |word| return true if text.include?(word) }
    return false
  end
end
