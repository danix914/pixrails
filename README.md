Setup step
    事前準備 - 待補完

* * *

1. 進EC2的web console，建立要用的image
    *   選img - debian-6.0-squeeze-base-x86_64-20110426 (ami-1cbc4375)

2. 開terminal連EC2上面的機器，並準備好要用的shell script，設定基本環境

        (local) $ ssh -i [your key] root@[EC2 public DNS]
        # apt-get update
        # apt-get upgrade
        # apt-get install -y sudo make sharutils
        # ./[script file]

3. 安裝vim, Git, tig, apache2, MySQL及一些lib

        # sudo apt-get install -y vim git-core tig apache2 mysql-server libmysqlclient-dev libreadline5-dev

4. 用Manic提供的vim環境       [參考出處: Manic的Github - dotvim](https://github.com/manic/dotvim)

        # cd [your work directory path]
        # git clone git://github.com/manic/dotvim.git
        # cd ~
        # ln -sfn [your work directory path]/dotvim .vim
        # ln -sfn [your work directory path]/dotvim/vimrc .vimrc

5. 安裝[Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/index.html)

        # wget http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb      (網址依系統決定)
        # dpkg -i ruby-enterprise_1.8.7-2011.03_amd64_debian6.0.deb
        # echo 'export PATH="/usr/local/lib/ruby/gems/1.8/bin:$PATH"' >> ~/.profile && . ~/.profile

6. 依指示安裝Passenger所需的套件

    `# /usr/local/bin/passenger-install-apache2-module`

    *   你應該會看到下列的訊息

             * Curl development headers with SSL support... not found
             * Apache 2 development headers... not found
             * Apache Portable Runtime (APR) development headers... not found
             * Apache Portable Runtime Utility (APU) development headers... not found

    *   所以安裝下面兩個要用到的套件

    `# apt-get install libcurl4-openssl-dev`

    `# apt-get install apache2-prefork-dev`

7. 設定Passenger

    `# gem install passenger -v [版號]`     (預設用3.0.2, 不加-v現在是裝3.0.8)

    *   將以下內容貼到/etc/apache2/mods-available/passenger.load    (此檔案要自己建立)

            LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.7/ext/apache2/mod_passenger.so
            PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.7
            PassengerRuby /usr/local/bin/ruby
            PassengerUserSwitching off
            PassengerDefaultUser root   (請依情況修改欲使用的 login ID)

8. 將Passenger的設定link到apache2

        # cd /etc/apach2/mods-enabled
        # sudo ln -s /etc/apache2/mods-available/passenger.load
