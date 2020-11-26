import email, smtplib, ssl

from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


import tkinter as tk
from tkinter import ttk
from tkinter import messagebox as mb

class Aplicacion:
    def __init__(self, *args):
        self.ventana1=tk.Tk()
        self.labelframe1=ttk.LabelFrame(self.ventana1, text="Send an email")
        self.labelframe1.grid(column=0, row=0, padx=10, pady=10)
        self.agregar_componentes()
        self.ventana1.mainloop()

    def agregar_componentes(self):
        self.label1=ttk.Label(self.labelframe1, text="Subject:")
        self.label1.grid(column=0, row=0, padx=5, pady=5, sticky="e")
        self.dato1=tk.StringVar()
        subject=ttk.Entry(self.labelframe1, textvariable=self.dato1)
        subject.grid(column=1, row=0, padx=5, pady=5)
        
        self.label2=ttk.Label(self.labelframe1, text="Body:")
        self.label2.grid(column=0, row=1, padx=5, pady=5, sticky="e")
        self.dato2=tk.StringVar()
        body=ttk.Entry(self.labelframe1, textvariable=self.dato2)
        body.grid(column=1, row=1, padx=5, pady=5)
        
        self.label2=ttk.Label(self.labelframe1, text="Your email:")
        self.label2.grid(column=0, row=2, padx=5, pady=5, sticky="e")
        self.dato3=tk.StringVar()
        sender_email=ttk.Entry(self.labelframe1, textvariable=self.dato3)
        sender_email.grid(column=1, row=2, padx=5, pady=5)
        
        self.label2=ttk.Label(self.labelframe1, text="Your password:")
        self.label2.grid(column=0, row=3, padx=5, pady=5, sticky="e")
        self.dato4=tk.StringVar()
        password=ttk.Entry(self.labelframe1, textvariable=self.dato4)
        password.grid(column=1, row=3, padx=5, pady=5)
        
        self.label2=ttk.Label(self.labelframe1, text="Receiver email:")
        self.label2.grid(column=0, row=4, padx=5, pady=5, sticky="e")
        self.dato5=tk.StringVar()
        receiver_email=ttk.Entry(self.labelframe1, textvariable=self.dato5)
        receiver_email.grid(column=1, row=4, padx=5, pady=5)
        
        self.label2=ttk.Label(self.labelframe1, text="File name:")
        self.label2.grid(column=0, row=5, padx=5, pady=5, sticky="e")
        self.dato6=tk.StringVar()
        filename=ttk.Entry(self.labelframe1, textvariable=self.dato6)
        filename.grid(column=1, row=5, padx=5, pady=5)

        self.boton1=ttk.Button(self.labelframe1, text="Enviar", command=self.email())
        self.boton1.grid(column=1, row=6, padx=5, pady=5, sticky="we")
        

    def email(self, *args):

        subject = "Mensaje MEME"
        body = "Ejercicio 10"
        sender_email = "test.pc.fcfm@gmail.com"
        password = "fcfm.123"
        receiver_email = "angelam.rochav@gmail.com"
        filename = "image.jpg"
        
        # Create a multipart message and set headers
        message = MIMEMultipart()
        message["From"] = sender_email
        message["To"] = receiver_email
        message["Subject"] = subject
        message["Bcc"] = receiver_email  # Recommended for mass emails

        # Add body to email
        message.attach(MIMEText(body, "plain"))


        # Open PDF file in binary mode
        with open(filename, "rb") as attachment:
            # Add file as application/octet-stream
            # Email client can usually download this automatically as attachment
            part = MIMEBase("application", "octet-stream")
            part.set_payload(attachment.read())

        # Encode file in ASCII characters to send by email    
        encoders.encode_base64(part)

        # Add header as key/value pair to attachment part
        part.add_header(
                        "Content-Disposition",
                        f"attachment; filename= {filename}",
        )

        # Add attachment to message and convert message to string
        message.attach(part)
        text = message.as_string()

        # Log in to server using secure context and send email
        context = ssl.create_default_context()
        with smtplib.SMTP_SSL("smtp.gmail.com", 465, context=context) as server:
            server.login(sender_email, password)
            server.sendmail(sender_email, receiver_email, text)
     

aplicacion1=Aplicacion()


