
feature 'Users can create a post' do
  scenario 'User creates a post' do
    sign_up
    post_message
    expect(current_path).to eq '/'
    expect(page).to have_content 'This is the best app ever!'
  end

  xscenario 'User can add a post to their account' do
    sign_up
    post_message
    expect(Post.all.map.to include(/This is the best app ever!/))
    # expect(link.tags.map(&:name)).to include('education')
  end
end

feature 'Users can view the time a post was created' do
  scenario 'User creates post and views the time on the index page' do
    sign_up
    post_message
    post = Post.first(user_id: 2)
    expect(page).to have_content "#{post.created_at.strftime("%d/%m/%Y %H:%M:%S")}"
  end
end

 feature 'Users change the chronological order of posts' do
  scenario 'user clicks a button to view posts oldest first' do
    sign_up
    post_message
    post_message(comment: 'This is the second message!')
    click_button 'Oldest first!'
    within 'li#highest' do
      expect(page).to have_content('This is the second message!')
      expect(page).not_to have_content('This is the best app ever!')
    end
  end
  scenario 'user clicks a button to view posts newest first' do
    sign_up
    post_message
    post_message(comment: 'This is the second message!')
    click_button 'Oldest first!'
    click_button 'Newest first!'
    within 'li#highest' do
      expect(page).to have_content('This is the best app ever!')
      expect(page).not_to have_content('This is the second message!')
    end
  end
end
