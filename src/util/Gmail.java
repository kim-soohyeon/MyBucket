package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
//���� gmail ������ ���� Class
public class Gmail extends Authenticator {
       
    PasswordAuthentication pa;
  
    public Gmail(){  //�����ڸ� ���� ���� ID/PW ����
          
        String id = "rlatngus1691@gmail.com";       // ���� ID
        String pw = "tngus0709^^";          // ���� ��й�ȣ
  
        // ID�� ��й�ȣ�� �Է��Ѵ�.
        pa = new PasswordAuthentication(id, pw);
    }
  
    // �ý��ۿ��� ����ϴ� ��������
    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
}

