Setup step
    # git clone git://github.com/danix914/pixrails.git
    # cd pixrails
    # ./rails_setup.sh  (run as administrator)

* * *
After execute the script file
1. 安裝[Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/index.html)

        # wget http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb      (網址依系統決定)
        # dpkg -i ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb
        # echo 'export PATH="/usr/local/lib/ruby/gems/1.8/bin:$PATH"' >> ~/.profile && . ~/.profile

2. 依指示安裝Passenger所需的套件

    `# /usr/local/bin/passenger-install-apache2-module`

    *   你應該會看到下列的訊息

             * Curl development headers with SSL support... not found
             * Apache 2 development headers... not found
             * Apache Portable Runtime (APR) development headers... not found
             * Apache Portable Runtime Utility (APU) development headers... not found

    *   所以安裝下面兩個要用到的套件

    `# apt-get install libcurl4-openssl-dev`

    `# apt-get install apache2-prefork-dev`

3. 設定Passenger

    `# gem install passenger -v [版號]`     (不加-v現在是裝3.0.8)

    *   將以下內容貼到/etc/apache2/mods-available/passenger.load    (此檔案要自己建立)

            LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.8/ext/apache2/mod_passenger.so
            PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.8
            PassengerRuby /usr/local/bin/ruby
            PassengerUserSwitching off
            PassengerDefaultUser root   (請依情況修改欲使用的 login ID)

4. 將Passenger的設定link到apache2

        # cd /etc/apach2/mods-enabled
        # sudo ln -s /etc/apache2/mods-available/passenger.load
