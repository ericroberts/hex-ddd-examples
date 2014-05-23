def stripe_success
  OpenStruct.new(
    JSON.parse(
      File.read('spec/support/stripe/success.json')
    )
  )
end
