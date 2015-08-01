function sendwarning(no,type,price)
%This function sends an email as a warning to me incase something happens

Mailaddress='1253705@tongji.edu.cn';
password='Tt0527!!!';
setpref('Internet','E_mail',Mailaddress);
setpref('Internet','SMTP_Server','smtp.tongji.edu.cn');
setpref('Internet','SMTP_Username',Mailaddress);
setpref('Internet','SMTP_Password',password);
props=java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
subject=strcat('A warning!',no,type,price);
content='FromMarkWarning!';
sendmail('superdoublet@hotmail.com',content,subject);

