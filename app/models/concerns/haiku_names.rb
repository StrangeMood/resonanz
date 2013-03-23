module Concerns::HaikuNames
  ADJECTIVES = %w(autumn hidden bitter misty silent empty dry dark summer icy delicate quiet white cool spring winter patient twilight dawn crimson wispy weathered blue billowing broken cold damp falling frosty green long late lingering bold little morning muddy old red rough still small sparkling throbbing shy wandering withered wild black young holy solitary fragrant aged snowy proud floral restless divine polished ancient purple lively nameless)
  NOUNS = %w(waterfall river breeze moon rain wind sea morning snow lake sunset pine shadow leaf dawn glitter forest hill cloud meadow sun glade bird brook butterfly bush dew dust field fire flower firefly feather grass haze mountain night pond darkness snowflake silence sound sky shape surf thunder violet water wildflower wave water resonance sun wood dream cherry tree fog frost voice paper frog smoke star)

  def haiku_name
    name = "#{ADJECTIVES.sample.capitalize} #{NOUNS.sample.capitalize} #{rand(64)+1}"
    self.class.exists?(name: name) ? haiku_name : name
  end
end