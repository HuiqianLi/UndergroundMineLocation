/****************************************************************************
** Meta object code from reading C++ file 'pickhandler.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../pickhandler.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'pickhandler.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_PickHandler_t {
    QByteArrayData data[11];
    char stringdata0[96];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_PickHandler_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_PickHandler_t qt_meta_stringdata_PickHandler = {
    {
QT_MOC_LITERAL(0, 0, 11), // "PickHandler"
QT_MOC_LITERAL(1, 12, 6), // "picked"
QT_MOC_LITERAL(2, 19, 0), // ""
QT_MOC_LITERAL(3, 20, 11), // "std::string"
QT_MOC_LITERAL(4, 32, 4), // "name"
QT_MOC_LITERAL(5, 37, 10), // "osg::Node*"
QT_MOC_LITERAL(6, 48, 4), // "node"
QT_MOC_LITERAL(7, 53, 8), // "unPicked"
QT_MOC_LITERAL(8, 62, 17), // "selectGroundPoint"
QT_MOC_LITERAL(9, 80, 9), // "osg::Vec3"
QT_MOC_LITERAL(10, 90, 5) // "point"

    },
    "PickHandler\0picked\0\0std::string\0name\0"
    "osg::Node*\0node\0unPicked\0selectGroundPoint\0"
    "osg::Vec3\0point"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_PickHandler[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   34,    2, 0x06 /* Public */,
       1,    1,   37,    2, 0x06 /* Public */,
       7,    1,   40,    2, 0x06 /* Public */,
       8,    1,   43,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 5,    6,
    QMetaType::Void, 0x80000000 | 5,    6,
    QMetaType::Void, 0x80000000 | 9,   10,

       0        // eod
};

void PickHandler::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        PickHandler *_t = static_cast<PickHandler *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->picked((*reinterpret_cast< const std::string(*)>(_a[1]))); break;
        case 1: _t->picked((*reinterpret_cast< osg::Node*(*)>(_a[1]))); break;
        case 2: _t->unPicked((*reinterpret_cast< osg::Node*(*)>(_a[1]))); break;
        case 3: _t->selectGroundPoint((*reinterpret_cast< osg::Vec3(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (PickHandler::*_t)(const std::string & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PickHandler::picked)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (PickHandler::*_t)(osg::Node * );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PickHandler::picked)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (PickHandler::*_t)(osg::Node * );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PickHandler::unPicked)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (PickHandler::*_t)(osg::Vec3 );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PickHandler::selectGroundPoint)) {
                *result = 3;
                return;
            }
        }
    }
}

const QMetaObject PickHandler::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_PickHandler.data,
      qt_meta_data_PickHandler,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *PickHandler::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PickHandler::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_PickHandler.stringdata0))
        return static_cast<void*>(const_cast< PickHandler*>(this));
    if (!strcmp(_clname, "osgGA::GUIEventHandler"))
        return static_cast< osgGA::GUIEventHandler*>(const_cast< PickHandler*>(this));
    return QObject::qt_metacast(_clname);
}

int PickHandler::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void PickHandler::picked(const std::string & _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void PickHandler::picked(osg::Node * _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void PickHandler::unPicked(osg::Node * _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void PickHandler::selectGroundPoint(osg::Vec3 _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_END_MOC_NAMESPACE
