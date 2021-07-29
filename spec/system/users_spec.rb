require 'rails_helper'

  RSpec.describe "Users", type: :system do
    let!(:user) { create(:user) }
    let!(:admin_user) { create(:user, :admin) } # 追記
    let!(:other_user) { create(:user) }  # 追加
    let!(:dish) { create(:dish, user: user) }
    let!(:other_dish) { create(:dish, user: other_user) }  # 追記


    describe "ユーザー一覧ページ" do
      context "管理者ユーザーの場合" do
        it "ぺージネーション、自分以外のユーザーの削除ボタンが表示されること" do
          create_list(:user, 30)
          login_for_system(admin_user)
          visit users_path
          expect(page).to have_css "div.pagination"
          User.paginate(page: 1).each do |u|
           expect(page).to have_link u.name, href: user_path(u)
            expect(page).to have_content "#{u.name} | 削除" unless u == admin_user
          end
        end
      end
      end

      context "管理者ユーザー以外の場合" do
        it "ぺージネーション、自分のアカウントのみ削除ボタンが表示されること" do
          create_list(:user, 30)
          login_for_system(user)
          visit users_path
          expect(page).to have_css "div.pagination"
          User.paginate(page: 1).each do |u|
            expect(page).to have_link u.name, href: user_path(u)
            if u == user
              expect(page).to have_content "#{u.name} | 削除"
            else
              expect(page).not_to have_content "#{u.name} | 削除"
            end
          end
        end
      end
    end
  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

      context "ユーザー登録処理" do
        it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
          fill_in "ユーザー名", with: "Example User"
          fill_in "メールアドレス", with: "user@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード(確認)", with: "password"
          click_button "登録する"
          expect(page).to have_content "クックログへようこそ！"
        end

        it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
          fill_in "ユーザー名", with: ""
          fill_in "メールアドレス", with: "user@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード(確認)", with: "pass"
          click_button "登録する"
          expect(page).to have_content "ユーザー名を入力してください"
          expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
        end
      end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit user_path(user)
      click_link "プロフィール編集"
    end

    context "ページレイアウト" do
      # it "正しいタイトルが表示されることを確認" do
      #   expect(page).to have_title full_title('プロフィール編集')
      # end
      # it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      #   fill_in "ユーザー名", with: "Edit Example User"
      #   fill_in "メールアドレス", with: "edit-user@example.com"
      #   fill_in "自己紹介", with: "編集：初めまして"
      #   fill_in "性別", with: "編集：男性"
      #   click_button "更新する"
      #   expect(page).to have_content "プロフィールが更新されました！"
      #   expect(user.reload.name).to eq "Edit Example User"
      #   expect(user.reload.email).to eq "edit-user@example.com"
      #   expect(user.reload.introduction).to eq "編集：初めまして"
      #   expect(user.reload.sex).to eq "編集：男性"
      # end
      # it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      #   fill_in "ユーザー名", with: ""
      #   fill_in "メールアドレス", with: ""
      #   click_button "更新する"
      #   expect(page).to have_content 'ユーザー名を入力してください'
      #   expect(page).to have_content 'メールアドレスを入力してください'
      #   expect(page).to have_content 'メールアドレスは不正な値です'
      #   expect(user.reload.email).not_to eq ""
      # end
    end

    context "アカウント削除処理", js: true do
      # it "正しく削除できること" do
      #   click_link "アカウントを削除する"
      #   page.driver.browser.switch_to.alert.accept
      #   expect(page).to have_content "自分のアカウントを削除しました"
      # end
    end
  end

    describe "プロフィールページ" do
      let(:user) { FactoryBot.create(:user) }

      context "ページレイアウト" do
        before do
          login_for_system(user)
          create_list(:dish, 10, user: user)
          visit user_path(user)
        end

        it "「プロフィール」の文字列が存在することを確認" do
          expect(page).to have_content 'プロフィール'
        end

        it "正しいタイトルが表示されることを確認" do
          expect(page).to have_title full_title('プロフィール')
        end

        it "ユーザー情報が表示されることを確認" do
          expect(page).to have_content user.name
          expect(page).to have_content user.introduction
          expect(page).to have_content user.sex
        end

        it "プロフィール編集ページへのリンクが表示されていることを確認" do
         expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
        end
         it "料理の件数が表示されていることを確認" do
          expect(page).to have_content "料理 (#{user.dishes.count})"
         end

        it "料理の情報が表示されていることを確認" do
          Dish.take(5).each do |dish|
            expect(page).to have_link dish.name
            expect(page).to have_content dish.description
            expect(page).to have_content dish.user.name
            expect(page).to have_content dish.required_time
            expect(page).to have_content dish.popularity
          end
        end
      end
        # it "料理のページネーションが表示されていることを確認" do
        #   expect(page).to have_css "div.pagination"
        # end
        
        context "ユーザーのフォロー/アンフォロー処理", js: true do
          # it "ユーザーのフォロー/アンフォローができること" do
          #   login_for_system(user)
          #   visit user_path(other_user)
          #   expect(page).to have_button 'フォローする'
          #   click_button 'フォローする'
          #   expect(page).to have_button 'フォロー中'
          #   click_button 'フォロー中'
          #   expect(page).to have_button 'フォローする'
          # end
        end 
        # context "お気に入り登録/解除" do
        #   before do
        #     login_for_system(user)
        #   end
        #   it "お気に入り一覧ページが期待通り表示されること" do
        #     visit favorites_path
        #     expect(page).not_to have_css ".favorite-dish"
        #     user.favorite(dish)
        #     user.favorite(other_dish)
        #     visit favorites_path
        #     expect(page).to have_css ".favorite-dish", count: 2
        #     expect(page).to have_content dish.name
        #     expect(page).to have_content dish.description
        #     expect(page).to have_content "cooked by #{user.name}"
        #     expect(page).to have_link user.name, href: user_path(user)
        #     expect(page).to have_content other_dish.name
        #     expect(page).to have_content other_dish.description
        #     expect(page).to have_content "cooked by #{other_user.name}"
        #     expect(page).to have_link other_user.name, href: user_path(other_user)
        #     user.unfavorite(other_dish)
        #     visit favorites_path
        #     expect(page).to have_css ".favorite-dish", count: 1
        #     expect(page).to have_content dish.name
        #   end
    
        #   it "料理のお気に入り登録/解除ができること" do
        #     expect(user.favorite?(dish)).to be_falsey
        #     user.favorite(dish)
        #     expect(user.favorite?(dish)).to be_truthy
        #     user.unfavorite(dish)
        #     expect(user.favorite?(dish)).to be_falsey
        #   end
        # end
        context "通知生成" do
          before do
            login_for_system(user)
          end
    
          context "自分以外のユーザーの料理に対して" do
            before do
              visit dish_path(other_dish)
            end
    
            it "お気に入り登録によって通知が作成されること" do
              find('.like').click
              visit dish_path(other_dish)
              expect(page).to have_css 'li.no_notification'
              logout
              login_for_system(other_user)
              expect(page).to have_css 'li.new_notification'
              visit notifications_path
              expect(page).to have_css 'li.no_notification'
              expect(page).to have_content "あなたの料理が#{user.name}さんにお気に入り登録されました。"
              expect(page).to have_content other_dish.name
              expect(page).to have_content other_dish.description
              expect(page).to have_content other_dish.created_at.strftime("%Y/%m/%d(%a) %H:%M")
            end
    
            it "コメントによって通知が作成されること" do
              fill_in "comment_content", with: "コメントしました"
              click_button "コメント"
              expect(page).to have_css 'li.no_notification'
              logout
              login_for_system(other_user)
              expect(page).to have_css 'li.new_notification'
              visit notifications_path
              expect(page).to have_css 'li.no_notification'
              expect(page).to have_content "あなたの料理に#{user.name}さんがコメントしました。"
              expect(page).to have_content '「コメントしました」'
              expect(page).to have_content other_dish.name
              expect(page).to have_content other_dish.description
              expect(page).to have_content other_dish.created_at.strftime("%Y/%m/%d(%a) %H:%M")
            end
          end
    
          context "自分の料理に対して" do
            before do
              visit dish_path(dish)
            end
    
            it "お気に入り登録によって通知が作成されないこと" do
              find('.like').click
              visit dish_path(dish)
              expect(page).to have_css 'li.no_notification'
              visit notifications_path
              expect(page).not_to have_content 'お気に入りに登録されました。'
              expect(page).not_to have_content dish.name
              expect(page).not_to have_content dish.description
              expect(page).not_to have_content dish.created_at
            end
    
            it "コメントによって通知が作成されないこと" do
              fill_in "comment_content", with: "自分でコメント"
              click_button "コメント"
              expect(page).to have_css 'li.no_notification'
              visit notifications_path
              expect(page).not_to have_content 'コメントしました。'
              expect(page).not_to have_content '自分でコメント'
              expect(page).not_to have_content other_dish.name
              expect(page).not_to have_content other_dish.description
              expect(page).not_to have_content other_dish.created_at
            end
          end
        end
      end
    