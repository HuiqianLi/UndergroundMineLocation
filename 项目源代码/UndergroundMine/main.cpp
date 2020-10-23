#include "MainWindow.h"
#include <QApplication>
#include <QTextCodec>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	//Set Encode
	QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
	MainWindow w;
	w.show();

	return a.exec();
}
