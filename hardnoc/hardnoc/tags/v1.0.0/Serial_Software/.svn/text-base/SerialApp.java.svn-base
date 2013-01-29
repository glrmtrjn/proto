/**
* Version 03.09.2003
*
* @author Leandro Heleno Möller
*
*/
import java.util.*;
import java.awt.event.*;
import java.awt.*;
import java.io.*;
import javax.comm.*;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.border.*;

public class SerialApp extends JFrame implements KeyListener,WindowListener,SerialPortEventListener,ActionListener,ItemListener
{
	// program variables
	private String port;
	private int speed, byteSize, parity, stopBits, readTimeout;
	private int iTransmitter,iReceiver,iChar,countReceiver=0,countTransmitter=0;
	private String directory=System.getProperty("user.dir")+File.separator;

	// terminal variables
	private Vector components;
	private JDialog dialog[];
	private JTextArea textarea[];
	private JTextField textfield[];
	private int width=200,height=300;
	private int machine=0,command,index=0;
	private String source;


	// graphical interface variables
	private JFrame frameConfig;
	private JFrame frameHelp;
	private JMenuBar menuBar;
	private JMenu meFile,meHelp,meSerial;
	private JMenuItem miExit,miDisconnect,miAbout,miConnect,miSaveTransmitter;
	private JMenuItem miSaveReceiver,miConfigure,miOpen,miHelp;
	private JPanel panelByteSize,panelStopBits,panelBaudRate,panelParity,panelPort;
	private JScrollPane spReceiver,spTransmitter;
	private JTextArea taReceiver,taTransmitter;
	private JLabel lTransmitter,lReceiver;
	private JLabel lTransmitter2,lReceiver2;
	private JLabel lProcessor;
	private JButton bCancelConfig,clearReceiver;
	private JButton bOKConfig,bSend,clearTransmitter;
	private JComboBox cbTarget, cbProcessor;
	private ButtonGroup groupBaudRate,groupParity,groupPort;
	private ButtonGroup groupByteSize,groupStopBits;
	private JRadioButton baud600,baud1200,baud2400,baud4800,baud9600;
	private JRadioButton baud19200,baud38400,baud56000,baud115200;
	private JRadioButton stopBits10,stopBits15,stopBits20;
	private JRadioButton com1,com2,com3,com4;
	private JRadioButton parityMark,parityNo,parityOdd,paritySpace,parityEven;
	private JRadioButton byteSize4,byteSize5,byteSize6,byteSize7,byteSize8;

	// serial interface variables
	private CommPortIdentifier portId;
	private SerialPort serialPort;
	private OutputStream outputStream;
	private InputStream inputStream;


	/**
	* @param args the command line arguments
	*/
	public static void main(String args[])
	{
		new SerialApp();
	}

    /**
    * Creates new form SerialApp
    */
    public SerialApp()
    {
        initComponents();
        initMenus();
        initVariables();
        setComponents();
        addKeyListener(this);
        setVisible(true);
    }

	/**
	* Create menus
	*/
    private void initMenus()
    {
        miOpen.setEnabled(true);
        miSaveReceiver.setEnabled(true);
        miSaveTransmitter.setEnabled(true);
        miExit.setEnabled(true);
        miHelp.setEnabled(true);
        miAbout.setEnabled(false);
    }

	/**
	* Set initial state variables
	*/
	private void initVariables()
	{
		port=getSelectedPort();
		speed=getSelectedSpeed();
		byteSize=getSelectedByteSize();
		parity=getSelectedParity();
		stopBits=getSelectedStopBits();
		readTimeout=2000;
		taReceiver.setEnabled(false);
		taTransmitter.setEnabled(false);
	}

	/**
	* Create graphical interface variables
	*/
	private void initComponents()
	{
		frameConfig = new JFrame();
		frameHelp = new JFrame();
		panelPort = new JPanel();
		com1 = new JRadioButton();
		com2 = new JRadioButton();
		com3 = new JRadioButton();
		com4 = new JRadioButton();
		panelBaudRate = new JPanel();
		baud600 = new JRadioButton();
		baud1200 = new JRadioButton();
		baud2400 = new JRadioButton();
		baud4800 = new JRadioButton();
		baud9600 = new JRadioButton();
		baud19200 = new JRadioButton();
		baud38400 = new JRadioButton();
		baud56000 = new JRadioButton();
		baud115200 = new JRadioButton();
		panelStopBits = new JPanel();
		stopBits15 = new JRadioButton();
		stopBits20 = new JRadioButton();
		stopBits10 = new JRadioButton();
		panelByteSize = new JPanel();
		byteSize4 = new JRadioButton();
		byteSize5 = new JRadioButton();
		byteSize6 = new JRadioButton();
		byteSize7 = new JRadioButton();
		byteSize8 = new JRadioButton();
		panelParity = new JPanel();
		parityNo = new JRadioButton();
		parityEven = new JRadioButton();
		parityOdd = new JRadioButton();
		parityMark = new JRadioButton();
		paritySpace = new JRadioButton();
		bCancelConfig = new JButton();
		bOKConfig = new JButton();
		groupPort = new ButtonGroup();
		groupBaudRate = new ButtonGroup();
		groupByteSize = new ButtonGroup();
		groupParity = new ButtonGroup();
		groupStopBits = new ButtonGroup();
		spTransmitter = new JScrollPane();
		taTransmitter = new JTextArea();
		spReceiver = new JScrollPane();
		taReceiver = new JTextArea();
		bSend = new JButton();
		lTransmitter = new JLabel();
		lReceiver = new JLabel();
		lTransmitter2 = new JLabel();
		lReceiver2 = new JLabel();
		lProcessor = new JLabel();
		clearTransmitter = new JButton();
		clearReceiver = new JButton();
		menuBar = new JMenuBar();
		meFile = new JMenu();
		miOpen = new JMenuItem();
		miSaveReceiver = new JMenuItem();
		miSaveTransmitter = new JMenuItem();
		miExit = new JMenuItem();
		miHelp = new JMenuItem();
		meSerial = new JMenu();
		miConnect = new JMenuItem();
		miDisconnect = new JMenuItem();
		miConfigure = new JMenuItem();
		meHelp = new JMenu();
		miAbout = new JMenuItem();
		cbTarget = new JComboBox();
		cbProcessor = new JComboBox();
	}

	/**
	* Create all the components
	*/
	public void setComponents()
	{
		setFrameConfig();
		setFrameHelp();

		getContentPane().setLayout(null);
		setTitle("Serial - version 04.30.2011");

		taTransmitter.setFont(new java.awt.Font("Courier New", 0, 12));
		spTransmitter.setViewportView(taTransmitter);
		getContentPane().add(spTransmitter);
		spTransmitter.setBounds(20, 30, 550, 100);

		taReceiver.setFont(new java.awt.Font("Courier New", 0, 12));
		spReceiver.setViewportView(taReceiver);
		getContentPane().add(spReceiver);
		spReceiver.setBounds(20, 190, 550, 110);

		bSend.setText("Send");
		bSend.addKeyListener(this);
		bSend.addActionListener(this);
		bSend.setEnabled(false);
		getContentPane().add(bSend);
		bSend.setBounds(500, 140, 70, 26);

		lTransmitter.setText(countTransmitter + " bytes to be transmitted");
		getContentPane().add(lTransmitter);
		lTransmitter.setBounds(425, 10, 200, 16);

		lReceiver.setText(countReceiver + " bytes received");
		getContentPane().add(lReceiver);
		lReceiver.setBounds(475, 170, 200, 16);

		lTransmitter2.setText("Transmitter");
		getContentPane().add(lTransmitter2);
		lTransmitter2.setBounds(20, 10, 200, 16);

		lReceiver2.setText("Receiver");
		getContentPane().add(lReceiver2);
		lReceiver2.setBounds(20, 170, 200, 16);

		clearReceiver.setText("Clear Receiver");
		clearReceiver.addKeyListener(this);
		clearReceiver.addActionListener(this);
		clearReceiver.setEnabled(false);
		getContentPane().add(clearReceiver);
		clearReceiver.setBounds(20, 140, 120, 26);

		clearTransmitter.setText("Clear Transmitter");
		clearTransmitter.addKeyListener(this);
		clearTransmitter.addActionListener(this);
		clearTransmitter.setEnabled(false);
		getContentPane().add(clearTransmitter);
		clearTransmitter.setBounds(150, 140, 140, 26);

		cbTarget.addKeyListener(this);
		getContentPane().add(cbTarget);
		cbTarget.setBounds(350,140,140,26);
		cbTarget.addItemListener(this);

		//le o arquivo config.cfg para capturar as informações do usuário
		getConfig();

		//le o arquivo processor.cfg para verificar quantos terminais
		//devem ser abertos
		getTerminals();

		//se tiver algum terminal a ser aberto, carrega os terminais
		if(components.size()>0);
			loadTerminals();

		//preenche o ComboBox com os arquivos TXT do diretório
		getFiles();

		meFile.setText("File");

		miOpen.setText("Open");
		miOpen.addActionListener(this);
		meFile.add(miOpen);

		miSaveReceiver.setText("Save Receiver");
		meFile.add(miSaveReceiver);
		miSaveReceiver.addActionListener(this);

		miSaveTransmitter.setText("Save Transmitter");
		meFile.add(miSaveTransmitter);
		miSaveTransmitter.addActionListener(this);

		meSerial.setText("Serial");

		miExit.setText("Exit");
		miExit.addActionListener(this);
		meFile.add(miExit);

		menuBar.add(meFile);

		miConnect.setText("Connect");
		miConnect.addActionListener(this);
		meSerial.add(miConnect);

		miDisconnect.setEnabled(false);
		miDisconnect.setText("Disconnect");
		miDisconnect.addActionListener(this);
		meSerial.add(miDisconnect);

		miConfigure.setText("Configure");
		miConfigure.addActionListener(this);
		meSerial.add(miConfigure);

		menuBar.add(meSerial);

		meHelp.setText("Help");

		miHelp.setText("Help");
		miHelp.addActionListener(this);
		meHelp.add(miHelp);

		miAbout.setText("About");
		meHelp.add(miAbout);

		menuBar.add(meHelp);

		setJMenuBar(menuBar);

		pack();

		java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
		setSize(new java.awt.Dimension(605, 363));
		setLocation((screenSize.width-605)/2,(screenSize.height-363)/2);
		addWindowListener(this);
	}

	/**
	* Serial Configuration Interface
	*/
	public void setFrameConfig()
	{
		frameConfig.getContentPane().setLayout(null);
		frameConfig.setTitle("Configuration");

		panelPort.setLayout(null);
		panelPort.setBorder(new TitledBorder("Port"));
		setPorts();
		frameConfig.getContentPane().add(panelPort);
		panelPort.setBounds(20, 10, 160, 80);

		panelByteSize.setLayout(null);
		panelByteSize.setBorder(new TitledBorder("Byte Size"));
		setByteSize();
		frameConfig.getContentPane().add(panelByteSize);
		panelByteSize.setBounds(20, 100, 70, 170);

		panelParity.setLayout(null);
		panelParity.setBorder(new TitledBorder("Parity"));
		setParity();
		frameConfig.getContentPane().add(panelParity);
		panelParity.setBounds(100, 100, 80, 170);

		panelBaudRate.setLayout(null);
		panelBaudRate.setBorder(new TitledBorder("Baud Rate"));
		setBaudRate();
		frameConfig.getContentPane().add(panelBaudRate);
		panelBaudRate.setBounds(190, 10, 250, 115);

		cbProcessor.addKeyListener(this);
		getContentPane().add(cbProcessor);
		frameConfig.getContentPane().add(cbProcessor);
		cbProcessor.setBounds(290,135,50,26);
		cbProcessor.addItemListener(this);

		//armazena no ComboBox apenas as combinacoes validas de largura
		//de palavra do processador para fazer o auto-complete no terminal
		cbProcessor.addItem("8");
		cbProcessor.addItem("16");
		cbProcessor.addItem("32");
		cbProcessor.setSelectedItem("16");

		lProcessor.setText("bits processor");
		frameConfig.getContentPane().add(lProcessor);
		lProcessor.setBounds(350,135,150,26);

		panelStopBits.setLayout(null);
		panelStopBits.setBorder(new TitledBorder("Stop Bits"));
		setStopBits();
		frameConfig.getContentPane().add(panelStopBits);
		panelStopBits.setBounds(190, 170, 250, 60);

		bCancelConfig.setText("Cancel");
		bCancelConfig.addActionListener(this);
		frameConfig.getContentPane().add(bCancelConfig);
		bCancelConfig.setBounds(230, 240, 73, 26);

		bOKConfig.setText("OK");
		bOKConfig.addActionListener(this);
		frameConfig.getContentPane().add(bOKConfig);
		bOKConfig.setBounds(340, 240, 51, 26);


	}

	/**
	* Program Help
	*/
	public void setFrameHelp()
	{
		//inicializa a janela do browser
		frameHelp.setTitle("Help da Serial");

		//permite que a janela seja fechada
		//frameHelp.addWindowListener(new WindowAdapter(){public void windowClosing(WindowEvent e){dispose();}});

		//cria um container
		Container c = frameHelp.getContentPane();

		//cria uma janela de visualização que não pode ser editada
		JEditorPane contents = new JEditorPane();
		contents.setEditable(false);

		//pega help.html do diretorio atual
		try
		{
			File f = new File("help.html");
			String path = f.getAbsolutePath();
			path = "file:///"+path;
			path = path.replace('\\', '/');
			contents.setPage(path);

		}
		catch(Exception e)
		{
			System.out.println("Impossible to find Help File");
		}

		c.add(new JScrollPane(contents),BorderLayout.CENTER);

		//inicializa a janela e mostra
		frameHelp.setSize(850,600);
	}


	/**
	* Create the graphical interface of the port settings
	*/
	public void setPorts()
	{
		com1.setText("COM1");
		groupPort.add(com1);
		panelPort.add(com1);
		com1.setBounds(10, 20, 59, 24);
		com1.setSelected(true);

		com2.setText("COM2");
		groupPort.add(com2);
		panelPort.add(com2);
		com2.setBounds(80, 20, 59, 24);

		com3.setText("COM3");
		groupPort.add(com3);
		panelPort.add(com3);
		com3.setBounds(10, 50, 59, 24);

		com4.setText("COM4");
		groupPort.add(com4);
		panelPort.add(com4);
		com4.setBounds(80, 50, 59, 24);
	}

	/**
	* Create the graphical interface of the baud rate
	*/
	public void setBaudRate()
	{
		baud600.setText("600");
		groupBaudRate.add(baud600);
		panelBaudRate.add(baud600);
		baud600.setBounds(20, 25, 46, 24);

		baud1200.setText("1200");
		groupBaudRate.add(baud1200);
		panelBaudRate.add(baud1200);
		baud1200.setBounds(100, 25, 53, 24);

		baud2400.setText("2400");
		groupBaudRate.add(baud2400);
		panelBaudRate.add(baud2400);
		baud2400.setBounds(170, 25, 53, 24);

		baud4800.setText("4800");
		groupBaudRate.add(baud4800);
		panelBaudRate.add(baud4800);
		baud4800.setBounds(20, 50, 53, 24);

		baud9600.setText("9600");
		groupBaudRate.add(baud9600);
		panelBaudRate.add(baud9600);
		baud9600.setBounds(100, 50, 53, 24);

		baud19200.setText("19200");
		groupBaudRate.add(baud19200);
		panelBaudRate.add(baud19200);
		baud19200.setBounds(170, 50, 60, 24);

		baud38400.setSelected(true);
		baud38400.setText("38400");
		groupBaudRate.add(baud38400);
		panelBaudRate.add(baud38400);
		baud38400.setBounds(20, 75, 60, 24);

		baud56000.setText("56000");
		groupBaudRate.add(baud56000);
		panelBaudRate.add(baud56000);
		baud56000.setBounds(100, 75, 60, 24);

		baud115200.setText("115200");
		groupBaudRate.add(baud115200);
		panelBaudRate.add(baud115200);
		baud115200.setBounds(170, 75, 67, 24);
	}

	/**
	* Create the graphical interface of the stop bits
	*/
	public void setStopBits()
	{
		stopBits15.setText("1,5");
		groupStopBits.add(stopBits15);
		panelStopBits.add(stopBits15);
		stopBits15.setBounds(100, 20, 42, 24);

		stopBits20.setText("2,0");
		groupStopBits.add(stopBits20);
		panelStopBits.add(stopBits20);
		stopBits20.setBounds(180, 20, 42, 24);

		stopBits10.setSelected(true);
		stopBits10.setText("1,0");
		groupStopBits.add(stopBits10);
		panelStopBits.add(stopBits10);
		stopBits10.setBounds(20, 20, 42, 24);
	}

	/**
	* Create the graphical interface of the byte size
	*/
	public void setByteSize()
	{
		byteSize4.setText("4");
		groupByteSize.add(byteSize4);
		panelByteSize.add(byteSize4);
		byteSize4.setBounds(10, 20, 32, 24);

		byteSize5.setText("5");
		groupByteSize.add(byteSize5);
		panelByteSize.add(byteSize5);
		byteSize5.setBounds(10, 50, 32, 24);

		byteSize6.setText("6");
		groupByteSize.add(byteSize6);
		panelByteSize.add(byteSize6);
		byteSize6.setBounds(10, 80, 32, 24);

		byteSize7.setText("7");
		groupByteSize.add(byteSize7);
		panelByteSize.add(byteSize7);
		byteSize7.setBounds(10, 110, 32, 24);

		byteSize8.setSelected(true);
		byteSize8.setText("8");
		groupByteSize.add(byteSize8);
		panelByteSize.add(byteSize8);
		byteSize8.setBounds(10, 140, 32, 24);
	}

	/**
	* Create the graphical interface of the parity
	*/
	public void setParity()
	{
		parityNo.setSelected(true);
		parityNo.setText("No");
		groupParity.add(parityNo);
		panelParity.add(parityNo);
		parityNo.setBounds(10, 20, 40, 24);

		parityEven.setText("Even");
		groupParity.add(parityEven);
		panelParity.add(parityEven);
		parityEven.setBounds(10, 50, 52, 24);

		parityOdd.setText("Odd");
		groupParity.add(parityOdd);
		panelParity.add(parityOdd);
		parityOdd.setBounds(10, 80, 48, 24);

		parityMark.setText("Mark");
		groupParity.add(parityMark);
		panelParity.add(parityMark);
		parityMark.setBounds(10, 110, 54, 24);

		paritySpace.setText("Space");
		groupParity.add(paritySpace);
		panelParity.add(paritySpace);
		paritySpace.setBounds(10, 140, 61, 24);
	}

	/**
	* Handle user events
	*/
	public void actionPerformed(ActionEvent e)
	{
		if(e.getActionCommand().equals("Cancel"))
			frameConfig.dispose();
		else if(e.getActionCommand().equals("OK"))
			setVariables();
		else if(e.getActionCommand().equals("Send"))
			send();
		else if(e.getActionCommand().equals("Clear Receiver"))
			clearReceiver();
		else if(e.getActionCommand().equals("Clear Transmitter"))
			clearTransmitter();
		else if(e.getActionCommand().equals("Open"))
			openFile();
		else if(e.getActionCommand().equals("Exit"))
			exit();
		else if(e.getActionCommand().equals("Save Receiver"))
			saveReceiver();
		else if(e.getActionCommand().equals("Save Transmitter"))
			saveTransmitter();
		else if(e.getActionCommand().equals("Connect"))
			connect();
		else if(e.getActionCommand().equals("Disconnect"))
			disconnect();
		else if(e.getActionCommand().equals("Configure"))
			configure();
		else if(e.getActionCommand().equals("Help"))
			frameHelp.show();
	}

	/**
	* Handle comboBox event
	*/
	public void itemStateChanged(ItemEvent e)
	{
		try
		{
			String recentEvent=cbTarget.getSelectedItem().toString();
			if(!recentEvent.equals(""))
				loadFile(directory+recentEvent+".txt");
		}
		catch(NullPointerException npe)
		{
		}
	}

	/**
	* Initiate serial
	* @param port serial port communication to be used
	* @param speed serial speed communication to be used
	* @param byteSize byte size to be used in the serial communication
	* @param parity parity to be used in the serial communication
	* @param stopBits number of stop bits to be used in the serial communication
	* @param readTimeout timeout of serial communication
	*/
	public boolean init(String port,int speed,int byteSize,int parity,int stopBits,int readTimeout)
	{
		try
		{
			portId = CommPortIdentifier.getPortIdentifier(port);
			serialPort = (SerialPort)portId.open("SerialApp", readTimeout);
			inputStream = serialPort.getInputStream();
			outputStream = serialPort.getOutputStream();
			serialPort.setSerialPortParams(speed,byteSize,stopBits,parity);
			serialPort.addEventListener(this);
			serialPort.notifyOnDataAvailable(true);
		}
		catch (PortInUseException e) {return false;}
		catch (IOException e) {return false;}
		catch (UnsupportedCommOperationException e) {return false;}
		catch (TooManyListenersException e) {return false;}
		catch (NoSuchPortException nspe) {return false;}
		catch (Exception e) {return false;}
		return true;
	}

	/**
	*Capture text files of the same directory of the program and feed the comboBox
	*/
	public void getFiles()
	{
		try
		{
			//monta o diretório atual
			File f=new File(directory);

			//pega todos os arquivos do diretorio
			File diretorio=new File(f,".");

			//cria um array com todos os nomes
			String arquivos[]=diretorio.list();

			//reinicializa os itens do combobox de acesso rapido a arquivos
			cbTarget.removeAllItems();

			//deixa apenas um item vazio no comeco do combobox
			cbTarget.addItem("");

			//armazena no ComboBox apenas os arquivos com extensão TXT
			for(int i=0;i<arquivos.length;i++)
			{
				int indexTXT=arquivos[i].indexOf(".txt");
				if(indexTXT!=-1)
					cbTarget.addItem(arquivos[i].substring(0,indexTXT));
			}
		}
		catch(Exception e)
		{
			System.out.println("Impossible to capture text files");
		}
	}

	/**
	* Read File config.cfg with the configurations
	*/
	public void getConfig()
	{
		try
		{
			String temp="";

			//captura o diretório atual
			String caminho=System.getProperty("user.dir")+File.separator+"config.cfg";

			//abre o arquivo selecionado
			BufferedReader br=open(caminho);

			//arquivo invalido, saindo do método
			if(br==null)
				return;

			//colocando todo o texto em uma linha só
			while(true)
			{
				temp=read(br);

				if(temp==null)
					break;
				if(temp.indexOf(File.separator)!=-1)
					directory=temp;
				else if(temp.indexOf("COM")!=-1)
				{
					if(temp.indexOf("COM1")!=-1)
						com1.setSelected(true);
					else if(temp.indexOf("COM2")!=-1)
						com2.setSelected(true);
					else if(temp.indexOf("COM3")!=-1)
						com3.setSelected(true);
					else if(temp.indexOf("COM4")!=-1)
						com4.setSelected(true);
				}
				else if(temp.indexOf("baud")!=-1)
				{
					if(temp.indexOf("baud600")!=-1)
						baud600.setSelected(true);
					else if(temp.indexOf("baud1200")!=-1)
						baud1200.setSelected(true);
					else if(temp.indexOf("baud2400")!=-1)
						baud2400.setSelected(true);
					else if(temp.indexOf("baud4800")!=-1)
						baud4800.setSelected(true);
					else if(temp.indexOf("baud9600")!=-1)
						baud9600.setSelected(true);
					else if(temp.indexOf("baud19200")!=-1)
						baud19200.setSelected(true);
					else if(temp.indexOf("baud38400")!=-1)
						baud38400.setSelected(true);
					else if(temp.indexOf("baud5600")!=-1)
						baud56000.setSelected(true);
					else if(temp.indexOf("baud115200")!=-1)
						baud115200.setSelected(true);
				}
				else if(temp.indexOf("stop")!=-1)
				{
					if(temp.indexOf("stopBits15")!=-1)
						stopBits15.setSelected(true);
					else if(temp.indexOf("stopBits20")!=-1)
						stopBits20.setSelected(true);
					else if(temp.indexOf("stopBits10")!=-1)
						stopBits10.setSelected(true);
				}
				else if(temp.indexOf("byteSize")!=-1)
				{
					if(temp.indexOf("byteSize4")!=-1)
						byteSize4.setSelected(true);
					else if(temp.indexOf("byteSize5")!=-1)
						byteSize5.setSelected(true);
					else if(temp.indexOf("byteSize6")!=-1)
						byteSize6.setSelected(true);
					else if(temp.indexOf("byteSize7")!=-1)
						byteSize7.setSelected(true);
					else if(temp.indexOf("byteSize8")!=-1)
						byteSize8.setSelected(true);
				}
				else if(temp.indexOf("parity")!=-1)
				{
					if(temp.indexOf("parityNo")!=-1)
						parityNo.setSelected(true);
					else if(temp.indexOf("parityEven")!=-1)
						parityEven.setSelected(true);
					else if(temp.indexOf("parityOdd")!=-1)
						parityOdd.setSelected(true);
					else if(temp.indexOf("parityMark")!=-1)
						parityMark.setSelected(true);
					else if(temp.indexOf("paritySpace")!=-1)
						paritySpace.setSelected(true);
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("Impossible to read config.cfg file");
		}
	}

	/**
	*Read File processor.cfg and create terminals to show scanf`s and printf`s
	*/
	public void getTerminals()
	{
		try
		{
			String temp="";
			Vector v;

			//inicializa o vetor de componentes lidos
			components=new Vector();

			//captura o diretório atual
			String caminho=directory+"processor.cfg";
			//abre o arquivo selecionado
			BufferedReader br=open(caminho);
			//arquivo invalido, saindo do método
			if(br==null)
				return;
			//colocando todo o texto em uma linha só
			while(true)
			{
				temp=read(br);

				if(temp==null)
					break;
				if(temp.indexOf(" ")!=-1)
				{
					v=new Vector();
					String origem=temp.substring(0,temp.indexOf(" "));
					String nome=temp.substring(temp.indexOf(" ")+1);
					v.addElement(origem);
					v.addElement(nome);
					components.addElement(v);
				}
				else
					System.out.println("Invalid processor.cfg file. You should use <number_core name>.");
			}
		}
		catch(Exception e)
		{
			System.out.println("Impossible to read processor.cfg file");
		}
	}


	/**
	*Convert the hexadecimal value to a decimal value and send by the serial interface
	*/
	public void write(String data)
	{
		try
		{
			String s=hex2dec(data);
			int i=Integer.valueOf(s).intValue();
			if(i>=128)
				i=i-256;
			outputStream.write(i);
		}
		catch (IOException e)
		{
			erro("Impossible to write by the serial interface");
		}
	}

	/**
	*Capture any serial events of the serial interface
	*/
	public void serialEvent(SerialPortEvent event)
	{
		byte[] readBuffer = new byte[20];
		int intData,numBytes=0;
		String stringData;

		try
		{
			//captura o numero de bytes recebidos no stream
			while (inputStream.available() > 0)
			{
				numBytes = inputStream.read(readBuffer);
			}

			//imprime todos os bytes que chegaram
			for(int i=0;i<numBytes;i++)
			{
				//passa byte(-128 .. +127) para positivo
				if(readBuffer[i]<0)
					intData=readBuffer[i]+256;
				else
					intData=readBuffer[i];

				//passa de inteiro para hexadecimal
				stringData=(Integer.toHexString(intData)).toUpperCase();

				//verifica se deve completar o valor com um zero
				if(stringData.length()==1)
					stringData="0" + stringData;

				//imprime na janela de recepcao
				appendReceiver(stringData);

				//atualiza o numero de bytes recebidos
				lReceiver.setText(countReceiver + " bytes received");

				boolean found=false;

				//verifica se chegou 55 55 55 55 XX YY
				//onde XX eh o endereco do core
				//onde YY eh o comando esperado

				//esperando os primeiros quatro 55
				if(machine<4)
				{
					source="";
					if(stringData.equals("55"))
						machine++;
					else
						index=machine=0;
				}

				//esperando um endereco origem valido
				else if(machine==4 && !stringData.equals("55"))
				{
					//percorre o vetor onde todos os cores estao cadastrados
					for(int j=0;j<components.size();j++)
					{
						//pega o elemento atual
						Vector v=(Vector)components.elementAt(j);
						//captura o endereco origem do core atual
						source=(v.elementAt(0).toString());
						//verifica se o endereco origem do core eh igual ao dado recebido
						if(stringData.equals(source))
						{
							//captura a posicao do core no vetor
							index=j;
							machine++;
							found=true;
							break;
						}
					}
					if(!found)
					{
						erro("Warning!! Four bytes with 55 and no valid source address arrived!!");
						//reiniciando maquina de espera de comandos
						machine=index=0;
					}
				}

				//esperando printf, scanf ou execution time
				else if(machine==5)
				{
					if ( stringData.equals("03") || stringData.equals("04") || stringData.equals("06"))
					{
						//capturando comando
						command=Integer.valueOf(stringData).intValue();

						//se for scanf
						if(command==4)
						{
							//habilita textfield para entrada de dados
							textfield[index].setEnabled(true);
							textfield[index].setBackground(Color.blue);
							textfield[index].requestFocus();

							//zera a maquina
							machine=index=0;
						}
						//se for printf, segue para o proximo estado
						else if(command==3 || command==6)
							machine++;
					}
					else
						erro("Warning!! Four bytes with 55 and a valid address arrived, but no valid command arrived!!");

				}
				else if(machine==6)
				{
					if(command==3)
						textarea[index].append("PRINT = " + stringData);
					else if(command==6)
						textarea[index].append("EXEC. TIME = " + stringData);
					machine++;
				}
				else if(machine==7 || machine==8)
				{
					if(command==3)
					{
						textarea[index].append(stringData+"\n");
						machine=index=0;
					}
					else if(command==6)
					{
						textarea[index].append(stringData);
						machine++;
					}
				}
				else if(machine==9)
				{
					textarea[index].append(stringData+"\n");
					machine=index=0;
				}

			}
		}
		catch (IOException e)
		{
			erro("Impossible to read by the serial interface");
		}
		catch (NumberFormatException nfe)
		{
			erro("Invalid number format");
		}
	}


	/**
	* Send a string by the serial interface
	*/
	public void sendSerial(String string)
	{
		//compacta o texto
		String sendString="";
		String compactado=compactText(string);
		int sendInt=0;

		if(!verifyChars(compactado))
		{
			erro("It was detected a invalid byte to send by the serial");
			return;
		}

		//envia um byte de cada vez, ou seja, dois caracteres
		for(int i=0;i<=compactado.length()-2;i=i+2)
		{
			sendString=compactado.substring(i,i+2);
			write(sendString);
		}

		cbTarget.setSelectedIndex(0);
	}

	/**
	* Check if the string has only hexadecimal values
	*/
	public boolean verifyChars(String string)
	{
		char c;
		for(int i=0;i<string.length();i++)
		{
			c=string.charAt(i);
			if( !( (c>='0' && c<='9') || ( c>='A' && c<='F') || ( c>='a' && c<='f') ) )
				return false;
		}
		return true;
	}

	/**
	* Append a string in the transmitter box
	*/
    private void appendTransmitter(String text)
    {
		taTransmitter.append(text);
    }

	/**
	* Append a string in the receiver box
	*/
    private void appendReceiver(String text)
    {
		if(iReceiver<25)
		{
        	taReceiver.append(text + " ");
        	iReceiver++;
        	countReceiver++;
		}
        else
        {
			taReceiver.append("\n" + text + " ");
			iReceiver=1;
			countReceiver++;
		}
    }

	/**
	* Show the dialog box to choose a file
	*/
    private void openFile()
    {
		//pegando o nome do arquivo e diretório selecionado
		FileDialog fload=new FileDialog(this,"Load",FileDialog.LOAD);

		//mostra arquivos com extensão TXT
		fload.setFile("*.txt");

		//abre o diretorio do usuário
		fload.setDirectory(directory);

		//mostra a tela de abrir arquivo
		fload.show();

		//pegando diretório e arquivo
		String open_dir=fload.getDirectory();
		String open_file=fload.getFile();
		String caminho=open_dir + open_file;

		repaint();

		//usuário cancelou, saindo do método
		if(open_file==null)
			return;
		else
			directory=open_dir;

		//busca os arquivos txt do diretorio aberto
		getFiles();

		//carrega o arquivo selecionado na caixa de transmissao
		loadFile(caminho);
	}

	/**
	* Load the requested file and append in the transmitter box
	*/
	private void loadFile(String caminho)
	{
		//variáveis locais
		String texto="";
		String temp;

		//abre o arquivo selecionado
		BufferedReader br=open(caminho);

		//arquivo invalido, saindo do método
		if(br==null)
			return;

		//colocando todo o texto em uma linha só
		while(true)
		{
			temp=read(br);
			if(temp==null)
				break;
			if(temp.indexOf("/")!=-1)
				temp=temp.substring(0,temp.indexOf("/"));
			if(temp.indexOf(";")!=-1)
				temp=temp.substring(0,temp.indexOf(";"));
			if(temp.indexOf("#")!=-1)
				temp=temp.substring(0,temp.indexOf("#"));
			if(temp.indexOf("\\t")!=-1)
				temp=temp.substring(0,temp.indexOf("\\t"));
			texto=texto+temp;
		}

		//organiza byte a byte o texto
		String organizado=organizeText(texto);

		//insere o texto na tela de transmissao
		insertTransmitterText(organizado);
	}

	/**
	* Insert organized text in transmitter window
	*/
	public void insertTransmitterText(String organizado)
	{
		//inicializa variáveis de controle
		int inicio=0;
		int fim=75;

		//apaga o texto antigo
		taTransmitter.setText("");

		//quebra o texto em linhas
		while(organizado.length()>inicio)
		{
			if(fim>organizado.length())
			{
				fim=organizado.length();
				appendTransmitter(organizado.substring(inicio,fim));
			}
			else
				appendTransmitter(organizado.substring(inicio,fim)+"\n");
			lReceiver.setText(countReceiver + " bytes received");
			inicio=inicio+75;
			fim=inicio+75;
		}


		//tira os espaços em branco
		String compactada=compactText(taTransmitter.getText());

		//acertando o iTransmitter para continuar digitando
		iTransmitter=compactada.length()%50;

		//acertando o iChar
		if(compactada.length()%2==0)
		{
			iChar=0;
			if(iTransmitter==0)
				appendTransmitter("\n");
			else
				appendTransmitter(" ");
		}
		else
			iChar=1;
	}

	/**
	* Show the number of terminals set by processor.cfg file
	*/
	public void loadTerminals()
	{
		textarea=new JTextArea[components.size()];
		textfield=new JTextField[components.size()];
		dialog=new JDialog[components.size()];

		for(int i=0;i<components.size();i++)
		{
			textarea[i]=new JTextArea(4,4);
			textarea[i].setFont(new Font("Courier New",Font.PLAIN,16));
			textarea[i].setBackground(Color.black);
			textarea[i].setForeground(Color.green);
			textarea[i].setEditable(false);

			textfield[i]=new JTextField();
			textfield[i].setFont(new Font("Courier New",Font.PLAIN,16));
			textfield[i].setBackground(Color.black);
			textfield[i].setForeground(Color.green);
			textfield[i].addKeyListener(this);

			String source=((Vector)components.elementAt(i)).elementAt(0).toString();
			String name=((Vector)components.elementAt(i)).elementAt(1).toString();

			dialog[i]=new JDialog(this,false);
			dialog[i].setSize(width,height);
			dialog[i].setTitle(source + " "+ name);
			dialog[i].getContentPane().setLayout(new BorderLayout());
			dialog[i].getContentPane().add("Center",new JScrollPane(textarea[i]));
			dialog[i].getContentPane().add("South",textfield[i]);
			dialog[i].addKeyListener(this);
			dialog[i].show();

			//Dimension resolucao=Toolkit.getDefaultTookit().getScreenSize();
			java.awt.Dimension resolucao = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
			if(i==0)
				dialog[i].setLocation(0,0);
			else if(i==1)
				dialog[i].setLocation((int)resolucao.getWidth()-width,0);
			else if(i==2)
				dialog[i].setLocation(0,(int)resolucao.getHeight()-height-20);
			else if(i==3)
				dialog[i].setLocation((int)resolucao.getWidth()-width,(int)resolucao.getHeight()-height-20);
			else
				dialog[i].setLocation(width,0);

		}
	}

	/**
	* Return a line of the file or null if it is the end of the file
	*/
	public String read(BufferedReader br)
	{
		try
		{
			return br.readLine();
		}
		catch(IOException ioe)
		{
			erro("Impossible to access file");
		}
		return null;
	}

	/**
	* Return a pointer of a file
	*/
	public BufferedReader open(String inFile)
	{
		FileInputStream fis;
		BufferedReader br=null;
		try
		{
			fis=new FileInputStream(inFile);
			br=new BufferedReader(new InputStreamReader(fis));
		}
		catch(FileNotFoundException fnfe)
		{
			System.out.println("File " +inFile+ " not found");
		}
		return br;
	}

	/**
	* Hot keys of the program
	*/
	public void keyPressed(KeyEvent e)
	{
		if(e.getSource() instanceof JTextField)
		{
			if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("ENTER"))
			{
				for(int i=0;i<components.size();i++)
					if(e.getSource()==textfield[i])
					{
						//captura o valor do textfield
						String valueScanf = textfield[i].getText();
						//captura o tamanho da palavra do processador em uso
						int processor=Integer.valueOf(""+cbProcessor.getSelectedItem()).intValue();
						//calcula quantos nibbles devem ser inseridos
						processor=processor/4;
						//concatena zeros se a entrada for menor o tamanho da palavra do processador
						for(int s=valueScanf.length();s<processor;s++)
							valueScanf= "0".concat(valueScanf);
						//restringe a tantos nibbles
						valueScanf=valueScanf.substring(0,processor);
						//sendSerial(textfield[i].getText());
						//passa o texto do textfield para a janela de comunicação deste core
						textarea[i].append("SCANF = " + valueScanf + "\n");


						//captura os dados do core para o qual deve responder o scanf
						Vector core=(Vector)components.elementAt(i);
						//captura o endereco do core
						String source=core.elementAt(0).toString();
						//organiza byte a byte o texto
						String organizado=organizeText("04"+source+valueScanf);
						//String organizado=organizeText("04"+source+valueScanf);
						//insere o texto na tela de transmissao
						insertTransmitterText(organizado);
						//envia o conteudo da janela de transmissao pela serial
						send();
						//limpa o textfield
						textfield[i].setText("");
						//desabilita o textfield
						textfield[i].setEnabled(false);
						//volta o textfield para a cor padrão
						textfield[i].setBackground(Color.black);
						//volta o foco para a janela principal
						this.requestFocus();
						bSend.requestFocus();
					}
			}
			return;
		}
		if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("F1"))
			frameHelp.show();
		if((e.getKeyModifiersText(e.getModifiers()).equals("Ctrl")))
		{
			if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("o"))
				openFile();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("r"))
				clearReceiver();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("t"))
				clearTransmitter();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("c"))
				connect();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("d"))
				disconnect();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("k"))
				configure();
			else if(e.getKeyText(e.getKeyCode()).equalsIgnoreCase("s"))
				send();
		}



		//System.out.println("key pressed");
		cbTarget.setSelectedIndex(0);

		//não deixa passar eventos que vem do TextField
		//if(e.getSource() instanceof JTextField)
		//	return;


		char key=e.getKeyChar();

		//não deixa passar eventos que vem do TextField
		//if(e.getSource() instanceof JTextField)
		//{
		//	if(key==e.VK_ENTER)
		//		textfield[index].setText("-"+key);
		//	return;
		//}


		if((key>='0' && key<='9') || (key>='a' && key<='f') || (key>='A' && key<='F'))
		{
			if(iChar==0)
			{
				appendTransmitter(""+key);
				iChar=1;
			}
			else
			{
				appendTransmitter(key + " ");
				//appendTransmitter(" ");
				countTransmitter++;
				lTransmitter.setText(countTransmitter + " bytes to be transmitted");
				iChar=0;
			}
			if(iTransmitter==49)
			{
				iTransmitter=0;
				appendTransmitter("\n");
			}
			else
			{
				iTransmitter++;
			}
		}
		else if(key==e.VK_BACK_SPACE)
		{
			String temp=taTransmitter.getText();
			if(temp.equals(""))
				return;

			if(iChar==1)
			{
				temp=temp.substring(0,temp.length()-1);
				iChar=0;
			}
			else
			{
				temp=temp.substring(0,temp.length()-2);
				iChar=1;
				if(iTransmitter>0)
					countTransmitter--;
				lTransmitter.setText(countTransmitter + " bytes to be transmitted");
			}
			if(iTransmitter==0)
			{
				iTransmitter=49;
				temp=temp.substring(0,temp.length()-1);
			}
			else
			{
				iTransmitter--;
			}
			taTransmitter.setText(temp);
		}
		else if(key==e.VK_ENTER)
			send();
	}

	/**
	* Events executed when the keys are released
	*/
	public void keyReleased(KeyEvent e){}

	/**
	* Insert and delete caracteres
	*/
	public void keyTyped(KeyEvent e)
	{
		//System.out.println("pressed");

	}

	/**
	* Compact the text and organize it byte a byte
	*/
	private String organizeText(String texto)
	{
		//compacta o texto
		String text=compactText(texto);
		//organiza o texto passado por parâmetro em bytes
		String correta=organizeInBytes(text);
		return correta;
	}

	/**
	* Put a text in a string
	*/
	private String compactText(String text)
	{
		int pos;
		String compactada=text;

		//retira os espaços em branco da string
		while(true)
		{
			pos=compactada.indexOf(" ");
			if(pos==-1)
				break;
			else
				compactada=compactada.substring(0,pos) + compactada.substring(pos+1);
		}

		//retira as novas linhas da string
		while(true)
		{
			pos=compactada.indexOf("\n");
			if(pos==-1)
				break;
			else
				compactada=compactada.substring(0,pos) + compactada.substring(pos+1);
		}

		return compactada;

	}

	/**
	* Organize text byte a byte
	*/
	private String organizeInBytes(String text)
	{
		String correta="";
		countTransmitter=1;
		//coloca um espaço a cada dois caracteres
		for(int i=0;i<text.length()-2;i=i+2)
		{
			correta=correta + text.substring(i,i+2) + " ";
			countTransmitter++;
		}
		lTransmitter.setText(countTransmitter + " bytes to be transmitted");
		if(text.length()%2==1)
			correta = correta + text.substring(text.length()-1);
		else
			correta = correta + text.substring(text.length()-2);
		return correta;
	}

	/**
	* Exit the aplication
	*/
	private void exit()
	{
		//fecha a porta serial
		if(!miConnect.isEnabled())
			serialPort.close();

		//salva o arquivo de configuração
		BufferedWriter bw=create(System.getProperty("user.dir")+File.separator+"config.cfg");

		//escreve armazena o último diretório que foi acessado
		write(bw,directory);

		write(bw,"\n");

		//salva a configuração da COM
		if(com1.isSelected())
			write(bw,"COM1");
		else if(com2.isSelected())
			write(bw,"COM2");
		else if(com3.isSelected())
			write(bw,"COM3");
		else if(com4.isSelected())
			write(bw,"COM4");
		else
			write(bw,"COM1");

		write(bw,"\n");

		//salva a configuração de baudRate
		if(baud600.isSelected())
			write(bw,"baud600");
		else if(baud1200.isSelected())
			write(bw,"baud1200");
		else if(baud2400.isSelected())
			write(bw,"baud2400");
		else if(baud4800.isSelected())
			write(bw,"baud4800");
		else if(baud9600.isSelected())
			write(bw,"baud9600");
		else if(baud19200.isSelected())
			write(bw,"baud19200");
		else if(baud38400.isSelected())
			write(bw,"baud38400");
		else if(baud56000.isSelected())
			write(bw,"baud56000");
		else if(baud115200.isSelected())
			write(bw,"baud115200");

		write(bw,"\n");

		//salva a configuração de stop bits
		if(stopBits15.isSelected())
			write(bw,"stopBits15");
		else if(stopBits20.isSelected())
			write(bw,"stopBits20");
		else if(stopBits10.isSelected())
			write(bw,"stopBits10");

		write(bw,"\n");


		//salva a configuração de byte size
		if(byteSize4.isSelected())
			write(bw,"byteSize4");
		else if(byteSize5.isSelected())
			write(bw,"byteSize5");
		else if(byteSize6.isSelected())
			write(bw,"byteSize6");
		else if(byteSize7.isSelected())
			write(bw,"byteSize7");
		else if(byteSize8.isSelected())
			write(bw,"byteSize8");

		write(bw,"\n");

		//salva a configuração de paridade
		if(parityNo.isSelected())
			write(bw,"parityNo");
		else if(parityEven.isSelected())
			write(bw,"parityEven");
		else if(parityOdd.isSelected())
			write(bw,"parityOdd");
		else if(parityMark.isSelected())
			write(bw,"parityMark");
		else if(paritySpace.isSelected())
			write(bw,"paritySpace");

		try
		{
			bw.close();
		}
		catch(Exception e)
		{
			System.out.println("Nao foi possivel salvar config.cfg em "+System.getProperty("user.dir")+File.separator);
		}


		//sai do programa
		System.exit(0);
	}

	/**
	* Write a string in a file
	*/
	public void write(BufferedWriter bw,String x)
	{
		try
		{
			bw.write(x,0,x.length());
		}
		catch(IOException ioe)
		{
			erro("Impossible to write file");
		}
	}

	/**
	* Create a file
	*/
	public BufferedWriter create(String caminho)
	{
		FileOutputStream fos;
		BufferedWriter bw=null;
		try
		{
			fos=new FileOutputStream(caminho);
			bw=new BufferedWriter(new OutputStreamWriter(fos));
		}
		catch(FileNotFoundException fnfe)
		{
			erro("Impossible to create file");
		}
		return bw;
	}

	/**
	* Get selected port
	*/
    private String getSelectedPort()
    {
        if(com1.isSelected())
            return "COM1";
        else if(com2.isSelected())
            return "COM2";
        else if(com3.isSelected())
            return "COM3";
        else
            return "COM4";
    }

	/**
	* Get selected speed of serial interface communication
	*/
    private int getSelectedSpeed()
    {
        if(baud600.isSelected())
            return 600;
        else if(baud1200.isSelected())
            return 1200;
        else if(baud2400.isSelected())
            return 2400;
        else if(baud4800.isSelected())
            return 4800;
        else if(baud9600.isSelected())
            return 9600;
        else if(baud19200.isSelected())
            return 19200;
        else if(baud38400.isSelected())
            return 38400;
        else if(baud56000.isSelected())
            return 56000;
        else
            return 115200;
    }

	/**
	* Get selected byte size to be sent to serial interface
	*/
    private int getSelectedByteSize()
    {
        if (byteSize4.isSelected())
            return 4;
        else if (byteSize5.isSelected())
            return 5;
        else if (byteSize6.isSelected())
            return 6;
        else if (byteSize7.isSelected())
            return 7;
        else
            return 8;
    }

	/**
	* Get selected parity to be used to access the serial interface
	*/
    private int getSelectedParity()
    {
        if (parityNo.isSelected())
            return 0;
        else if (parityOdd.isSelected())
            return 1;
        else if (parityEven.isSelected())
            return 2;
        else if (parityMark.isSelected())
            return 3;
        else
            return 4;
    }

	/**
	* Get selected number of stop bits
	*/
    private int getSelectedStopBits()
    {
        if (stopBits10.isSelected())
            return 1;
        else if(stopBits20.isSelected())
            return 2;
        else
            return 3;
    }

	/**
	* Converts a hexadecimal string to a decimal string
	*/
	public String hex2dec(String valor)
	{
		valor=valor.toUpperCase();
		char[] carac ={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		long aux=0;
		for (int j=0;j<valor.length();j++)
			for (int i=0;i<16;i++)
				if ( carac[i]==valor.charAt(valor.length()-j-1))
					aux=aux+(int)Math.pow(16,j)*i;
		return(""+aux);
	}

	/**
	* Show an error message
	*/
	public void erro(String msg)
	{
		JOptionPane.showMessageDialog(this,msg,"ERRO", JOptionPane.ERROR_MESSAGE);
		this.repaint();
	}

	/**
	* Clear receiver
	*/
	public void clearReceiver()
	{
		taReceiver.setText("");
		iReceiver=countReceiver=0;
		lReceiver.setText(countReceiver + " bytes received");
	}

	/**
	* Clear transmitter
	*/
	public void clearTransmitter()
	{
		taTransmitter.setText("");
		iTransmitter=countTransmitter=iChar=0;
		lTransmitter.setText(countTransmitter + " bytes to be transmitted");
		cbTarget.setSelectedIndex(0);
	}

	/**
	* Connect
	*/
	public void connect()
	{
		setVariables();
		if(!init(port,speed,byteSize,parity,stopBits,readTimeout))
		{
			erro("Impossible to communicate with the serial interface");
			return;
		}

		//habilita botões
		miConnect.setEnabled(false);
		miDisconnect.setEnabled(true);
		bSend.setEnabled(true);
		bSend.requestFocus();
		clearTransmitter.setEnabled(true);
		clearReceiver.setEnabled(true);
	}

	/**
	* Disconnect
	*/
	public void disconnect()
	{
		//fecha a porta serial
		serialPort.close();

		//habilita botões
		miConnect.setEnabled(true);
		miDisconnect.setEnabled(false);
		bSend.setEnabled(false);
		clearTransmitter.setEnabled(false);
		clearReceiver.setEnabled(false);
	}

	/**
	* Show configure screen
	*/
	public void configure()
	{
		frameConfig.setSize(new java.awt.Dimension(470, 360));
		frameConfig.show();
	}

	/**
	* Check if it is attempt to send data
	*/
	public void send()
	{
		//se não está conectado avisa, se estiver envia
		if(miConnect.isEnabled())
			erro("Serial is not connected");
		else
			sendSerial(taTransmitter.getText());
	}

	/**
	* Save transmission box
	*/
	public void saveTransmitter()
	{
		FileDialog fsave=new FileDialog(this,"Salvar",FileDialog.SAVE);

		//abre a tela de escolher o arquivo a salvar
		fsave.setFile("*.txt");
		fsave.show();

		//captura o arquivo selecionado
		String open_file=fsave.getFile();
		String open_dir=fsave.getDirectory();

		//se a operação foi cancelada pelo usuário retorna
		if(open_file==null)
			return;

		//cria o arquivo especificado
		BufferedWriter bw=create(open_dir + open_file);

		//escreve o conteúdo da tela de recepção no arquivo
		write(bw,taTransmitter.getText());

		//repinta a tela
		repaint();

		//fecha o arquivo
		try
		{
			bw.close();
		}
		catch(IOException ioe)
		{
			erro("Impossible to close file");
		}
	}

	/**
	* Save receiver box
	*/
	public void saveReceiver()
	{
		FileDialog fsave=new FileDialog(this,"Salvar",FileDialog.SAVE);

		//abre a tela de escolher o arquivo a salvar
		fsave.setFile("*.txt");
		fsave.show();

		//captura o arquivo selecionado
		String open_file=fsave.getFile();
		String open_dir=fsave.getDirectory();

		//se a operação foi cancelada pelo usuário retorna
		if(open_file==null)
			return;

		//cria o arquivo especificado
		BufferedWriter bw=create(open_dir + open_file);

		//escreve o conteúdo da tela de recepção no arquivo
		write(bw,taReceiver.getText());

		//repinta a tela
		repaint();

		//fecha o arquivo
		try
		{
			bw.close();
		}
		catch(IOException ioe)
		{
			erro("Impossible to close file");
		}
	}

	/**
	* Set configuration variables
	*/
	public void setVariables()
	{
		port=getSelectedPort();
		speed=getSelectedSpeed();
		byteSize=getSelectedByteSize();
		parity=getSelectedParity();
		stopBits=getSelectedStopBits();
		frameConfig.dispose();
	}


	public void windowOpened(WindowEvent e){}
	public void windowIconified(WindowEvent e){}
	public void windowDeiconified(WindowEvent e){}
	public void windowClosed(WindowEvent e){}
	public void windowActivated(WindowEvent e){}
	public void windowDeactivated(WindowEvent e){}
	public void windowClosing(WindowEvent e){exit();}
}