import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ColchoCheckApp());
}

const String kOfficialIconB64 = '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';

class ColchoCheckApp extends StatelessWidget {
  const ColchoCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColchoCheck • Super Colchones GNC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B1F38),
          primary: const Color(0xFF0B1F38),
          secondary: const Color(0xFF1D4ED8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3EFE7),
        useMaterial3: true,
      ),
      home: const MainShellScreen(),
    );
  }
}

class Usuario {
  final String id;
  final String pass;
  final String nombre;
  final String rol; // promotor | supervisor | ejecutivo | admin
  final String puesto;
  final String plaza;
  bool activo;

  Usuario({
    required this.id,
    required this.pass,
    required this.nombre,
    required this.rol,
    required this.puesto,
    required this.plaza,
    this.activo = true,
  });
}

class Sucursal {
  final String codigo;
  final String nombre;
  final String plaza;
  final String supervisorId;
  final String tipoZona; // LOCAL_GDL | FORANEA
  final String horario;
  final double lat;
  final double lng;
  final double metaPzs;
  final double metaPesos;
  double avancePzs;
  bool visitadaMes;

  Sucursal({
    required this.codigo,
    required this.nombre,
    required this.plaza,
    required this.supervisorId,
    required this.tipoZona,
    required this.horario,
    required this.lat,
    required this.lng,
    required this.metaPzs,
    required this.metaPesos,
    required this.avancePzs,
    this.visitadaMes = false,
  });
}

class VisitaSupervisor {
  final String id;
  final String supervisorId;
  final String tipo; // Sucursal | Garantia
  final String sucursalCodigo;
  final String destinoNombre;
  final String folioGarantia;
  final String dictamenGarantia;
  final List<bool> fotosGarantia;
  String estatus; // Pendiente | En Curso | Cerrada
  String? horaEntrada;
  String? horaSalida;

  VisitaSupervisor({
    required this.id,
    required this.supervisorId,
    required this.tipo,
    required this.sucursalCodigo,
    required this.destinoNombre,
    this.folioGarantia = '',
    this.dictamenGarantia = 'Procede Cambio Físico',
    List<bool>? fotosGarantia,
    this.estatus = 'Pendiente',
    this.horaEntrada,
    this.horaSalida,
  }) : fotosGarantia = fotosGarantia ?? [false, false, false, false, false, false];
}

class AppData {
  static String fechaCorteSellOut = '11.nov.26';

  static final List<String> etiquetasFotosGarantia = [
    '1. Etiqueta / No. Serie',
    '2. Vista Superior Completa',
    '3. Evidencia Hundimiento/Daño',
    '4. Base o Box del Cliente',
    '5. Costuras y Bordes',
    '6. Póliza / Hoja Firmada',
  ];

  static final List<Usuario> usuarios = [
    Usuario(id: 'VENTAS1.MOSS', pass: 'America.24\$', nombre: 'MOISES AVILA', rol: 'admin', puesto: 'EJECUTIVO DE CUENTA', plaza: 'NACIONAL'),
    Usuario(id: 'ADMIN1.MOSS', pass: 'America.24\$', nombre: 'MOISES AVILA', rol: 'admin', puesto: 'ADMIN', plaza: 'NACIONAL'),
    Usuario(id: 'DEMO.1ADMIN', pass: 'America.2026\$', nombre: 'MODO DEMO / PRUEBAS', rol: 'admin', puesto: 'ADMIN DEMO', plaza: 'NACIONAL'),
    Usuario(id: 'GERENTE1.DANY', pass: 'America.2026\$', nombre: 'DANIELA REYES', rol: 'ejecutivo', puesto: 'GERENTE', plaza: 'NACIONAL'),
    Usuario(id: 'DIREC1.TEMOC', pass: 'America.2026\$', nombre: 'CUAUHTÉMOC', rol: 'ejecutivo', puesto: 'DIRECTOR COMERCIAL', plaza: 'NACIONAL'),
    Usuario(id: 'SUPER1.ISRAEL', pass: 'America.2026\$', nombre: 'ISRAEL SOLANO', rol: 'supervisor', puesto: 'SUPERVISOR', plaza: 'ZMG / FORÁNEAS'),
    Usuario(id: 'SUPER2.JONA', pass: 'America.2026\$', nombre: 'JONATHAN', rol: 'supervisor', puesto: 'SUPERVISOR', plaza: 'ZMG / PACÍFICO'),
    Usuario(id: 'PROMO1.GDL', pass: 'America.2026\$', nombre: 'PROMOTOR 1 GDL', rol: 'promotor', puesto: 'PROMOTOR', plaza: 'GUADALAJARA'),
    Usuario(id: 'PROMO2.GDL', pass: 'America.2026\$', nombre: 'PROMOTOR 2 GDL', rol: 'promotor', puesto: 'PROMOTOR', plaza: 'GUADALAJARA'),
    Usuario(id: 'PROMO3.CLN', pass: 'America.2026\$', nombre: 'PROMOTOR 3 GDL', rol: 'promotor', puesto: 'PROMOTOR', plaza: 'GUADALAJARA'),
    Usuario(id: 'PROMO4.PVR', pass: 'America.2026\$', nombre: 'PROMOTOR 4 VALLARTA', rol: 'promotor', puesto: 'PROMOTOR', plaza: 'PUERTO VALLARTA'),
  ];

  static final List<Sucursal> sucursales = [
    Sucursal(codigo: '0', nombre: 'OFICINA AMERICA GDL', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'OFICINA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.654800, lng: -103.356200, metaPzs: 0.0, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '1', nombre: 'PATRIA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.712100, lng: -103.378200, metaPzs: 1.2, metaPesos: 4536.00, avancePzs: 1.0),
    Sucursal(codigo: '2', nombre: 'TERRANOVA', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER3', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.684500, lng: -103.389100, metaPzs: 0.0, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '3', nombre: 'COPÉRNICO', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.631900, lng: -103.416800, metaPzs: 51.6, metaPesos: 249342.00, avancePzs: 5.0),
    Sucursal(codigo: '7', nombre: 'CD.GUZMAN', plaza: 'Cd. Guzmán', supervisorId: 'SUPER3', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.704200, lng: -103.461800, metaPzs: 8.4, metaPesos: 34875.60, avancePzs: 0.0),
    Sucursal(codigo: '8', nombre: 'JUÁREZ', plaza: 'ZMG Jalisco (Centro GDL)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.674800, lng: -103.354100, metaPzs: 12.0, metaPesos: 72006.00, avancePzs: 0.0),
    Sucursal(codigo: '9', nombre: 'PLAZA DEL SOL', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER2.JONA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.650800, lng: -103.402100, metaPzs: 8.4, metaPesos: 48352.80, avancePzs: 2.0),
    Sucursal(codigo: '11', nombre: 'TLAQUEPAQUE', plaza: 'ZMG Jalisco (Tlaquepaque)', supervisorId: 'SUPER2.JONA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.641200, lng: -103.313400, metaPzs: 21.6, metaPesos: 133742.40, avancePzs: 3.0),
    Sucursal(codigo: '14', nombre: 'REVOLUCIÓN', plaza: 'ZMG Jalisco (GDL Oriente)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.653100, lng: -103.309500, metaPzs: 28.8, metaPesos: 132477.60, avancePzs: 2.0),
    Sucursal(codigo: '15', nombre: 'GOBERNADOR CURIEL', plaza: 'ZMG Jalisco (GDL Sur)', supervisorId: 'SUPER2.JONA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.633500, lng: -103.351200, metaPzs: 14.4, metaPesos: 67858.80, avancePzs: 7.0),
    Sucursal(codigo: '140', nombre: 'EXPO TERRAZA BELENES', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.738100, lng: -103.401500, metaPzs: 0.0, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '191', nombre: 'EXPO WALMART CIMA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.751200, lng: -103.431000, metaPzs: 5.0, metaPesos: 25000.00, avancePzs: 0.0),
    Sucursal(codigo: '16', nombre: 'CIRCUNVALACIÓN', plaza: 'ZMG Jalisco (GDL Norte)', supervisorId: 'SUPER2.JONA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.697500, lng: -103.348200, metaPzs: 7.2, metaPesos: 24852.00, avancePzs: 0.0),
    Sucursal(codigo: '18', nombre: 'JARDINES DE GUADALUPE', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.668200, lng: -103.419500, metaPzs: 26.4, metaPesos: 142484.40, avancePzs: 5.0),
    Sucursal(codigo: '19', nombre: 'SAN ISIDRO', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.742500, lng: -103.386100, metaPzs: 8.4, metaPesos: 30880.80, avancePzs: 1.0),
    Sucursal(codigo: '26', nombre: 'OBREGÓN', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.791500, lng: -107.394200, metaPzs: 13.2, metaPesos: 64429.20, avancePzs: 0.0),
    Sucursal(codigo: '29', nombre: 'ZAPATA 2', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.789200, lng: -107.418500, metaPzs: 2.4, metaPesos: 7916.40, avancePzs: 0.0),
    Sucursal(codigo: '31', nombre: 'ALMADA', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.803500, lng: -107.391000, metaPzs: 6.0, metaPesos: 35816.40, avancePzs: 0.0),
    Sucursal(codigo: '40', nombre: 'AV.MÉXICO', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.679500, lng: -103.384200, metaPzs: 3.6, metaPesos: 23628.00, avancePzs: 0.0),
    Sucursal(codigo: '41', nombre: 'ANDARES', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.708900, lng: -103.411800, metaPzs: 7.2, metaPesos: 47889.60, avancePzs: 3.0),
    Sucursal(codigo: '45', nombre: 'CENTRO SUR', plaza: 'ZMG Jalisco (Tlaquepaque)', supervisorId: 'SUPER2.JONA', tipoZona: 'LOCAL_GDL', horario: '10:00-20:00', lat: 20.604200, lng: -103.400800, metaPzs: 13.2, metaPesos: 54664.80, avancePzs: 5.0),
    Sucursal(codigo: '48', nombre: 'PLAZA CARACOL', plaza: 'Puerto Vallarta', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.642500, lng: -105.232800, metaPzs: 34.8, metaPesos: 141026.40, avancePzs: 5.0),
    Sucursal(codigo: '64', nombre: 'COMERCIAL MEXICANA', plaza: 'Colima', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.248500, lng: -103.729000, metaPzs: 21.6, metaPesos: 109975.20, avancePzs: 1.0),
    Sucursal(codigo: '68', nombre: 'CONSTITUCIÓN', plaza: 'Colima', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.261200, lng: -103.714500, metaPzs: 1.0, metaPesos: 2500.00, avancePzs: 0.0),
    Sucursal(codigo: '69', nombre: 'ADOLF HORN', plaza: 'ZMG Jalisco (Tlajomulco)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.569500, lng: -103.364200, metaPzs: 30.0, metaPesos: 85356.00, avancePzs: 0.0),
    Sucursal(codigo: '72', nombre: 'LAGO REAL', plaza: 'Bahía de Banderas / Vallarta', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.728500, lng: -105.276200, metaPzs: 15.6, metaPesos: 60784.80, avancePzs: 5.0),
    Sucursal(codigo: '78', nombre: 'ARCOS ESTAMPIDA', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER3', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.674200, lng: -103.388500, metaPzs: 2.4, metaPesos: 13345.20, avancePzs: 0.0),
    Sucursal(codigo: '82', nombre: 'RAFAEL BUELNA', plaza: 'Mazatlán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 23.241500, lng: -106.439200, metaPzs: 2.0, metaPesos: 2500.00, avancePzs: 1.0),
    Sucursal(codigo: '84', nombre: 'VALLE DE LAS GARZAS', plaza: 'Manzanillo', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.086500, lng: -104.298200, metaPzs: 2.4, metaPesos: 14331.60, avancePzs: 3.0),
    Sucursal(codigo: '85', nombre: 'RIOJA', plaza: 'ZMG Jalisco (Tlajomulco)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.562100, lng: -103.452800, metaPzs: 7.2, metaPesos: 34227.60, avancePzs: 0.0),
    Sucursal(codigo: '88', nombre: 'EL SALTO', plaza: 'ZMG Jalisco (El Salto)', supervisorId: 'SUPER3', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.521500, lng: -103.184200, metaPzs: 3.6, metaPesos: 23220.00, avancePzs: 0.0),
    Sucursal(codigo: '89', nombre: 'MARINA', plaza: 'Puerto Vallarta', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.661500, lng: -105.247800, metaPzs: 7.2, metaPesos: 42124.80, avancePzs: 2.0),
    Sucursal(codigo: '90', nombre: 'U DE O', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.819500, lng: -107.411200, metaPzs: 8.4, metaPesos: 43322.40, avancePzs: 0.0),
    Sucursal(codigo: '91', nombre: 'CIMA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.751800, lng: -103.431500, metaPzs: 9.6, metaPesos: 51619.20, avancePzs: 1.0),
    Sucursal(codigo: '92', nombre: 'PINO SUAREZ', plaza: 'Colima', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.239800, lng: -103.721500, metaPzs: 1.2, metaPesos: 4536.00, avancePzs: 0.0),
    Sucursal(codigo: '93', nombre: 'CHAPULTEPEC', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.672500, lng: -103.368800, metaPzs: 1.0, metaPesos: 2500.00, avancePzs: 1.0),
    Sucursal(codigo: '94', nombre: 'SENDEROS MAZA', plaza: 'Mazatlán', supervisorId: 'SUPER3', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 23.268500, lng: -106.412500, metaPzs: 4.8, metaPesos: 23637.60, avancePzs: 0.0),
    Sucursal(codigo: '95', nombre: 'PLAZA ALICA', plaza: 'Tepic', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 21.495800, lng: -104.899200, metaPzs: 13.2, metaPesos: 47496.00, avancePzs: 3.0),
    Sucursal(codigo: '99', nombre: 'RÍO NILO', plaza: 'ZMG Jalisco (Tonalá / Tlaq.)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.638200, lng: -103.284500, metaPzs: 28.8, metaPesos: 149116.80, avancePzs: 2.0),
    Sucursal(codigo: '100', nombre: 'PLAZA UBIKA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.761500, lng: -103.451200, metaPzs: 6.0, metaPesos: 30780.00, avancePzs: 1.0),
    Sucursal(codigo: '114', nombre: 'PLAZA LUCCA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.729500, lng: -103.432800, metaPzs: 1.2, metaPesos: 11400.00, avancePzs: 0.0),
    Sucursal(codigo: '124', nombre: 'EXPO TERRAZA OBLATOS', plaza: 'ZMG Jalisco (GDL Oriente)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.689500, lng: -103.296200, metaPzs: 72.0, metaPesos: 292474.80, avancePzs: 4.0),
    Sucursal(codigo: '128', nombre: 'AVIACIÓN', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.719500, lng: -103.455200, metaPzs: 8.4, metaPesos: 49472.40, avancePzs: 4.0),
    Sucursal(codigo: '137', nombre: 'PLAZA ALCALDE', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.692800, lng: -103.350800, metaPzs: 1.2, metaPesos: 11400.00, avancePzs: 0.0),
    Sucursal(codigo: '145', nombre: 'PLAZA JACARANDAS', plaza: 'Tepic', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 21.498200, lng: -104.906500, metaPzs: 7.2, metaPesos: 34441.20, avancePzs: 0.0),
    Sucursal(codigo: '148', nombre: 'PLAZA PALMAS', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.782500, lng: -107.405200, metaPzs: 1.0, metaPesos: 2500.00, avancePzs: 1.0),
    Sucursal(codigo: '149', nombre: 'MARIA AHUMADA', plaza: 'Villa de Álvarez / Colima', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.274500, lng: -103.736200, metaPzs: 1.0, metaPesos: 2500.00, avancePzs: 0.0),
    Sucursal(codigo: '150', nombre: 'CAMPIÑA', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.806500, lng: -107.369500, metaPzs: 3.6, metaPesos: 19633.20, avancePzs: 0.0),
    Sucursal(codigo: '152', nombre: 'EXPO MARIANO OTERO', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.648500, lng: -103.404200, metaPzs: 105.6, metaPesos: 480301.20, avancePzs: 0.0),
    Sucursal(codigo: '164', nombre: 'GALERÍAS', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.677500, lng: -103.431800, metaPzs: 9.6, metaPesos: 47384.40, avancePzs: 2.0),
    Sucursal(codigo: '168', nombre: 'PLAZA FÓRUM', plaza: 'Culiacán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 24.812800, lng: -107.399200, metaPzs: 3.6, metaPesos: 21062.40, avancePzs: 0.0),
    Sucursal(codigo: '183', nombre: 'EXPO REAL CENTER', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.731800, lng: -103.428500, metaPzs: 19.2, metaPesos: 121108.80, avancePzs: 0.0),
    Sucursal(codigo: '193', nombre: 'CENTRO MANZANILLO', plaza: 'Manzanillo', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.054200, lng: -104.316800, metaPzs: 3.6, metaPesos: 10914.00, avancePzs: 1.0),
    Sucursal(codigo: '195', nombre: 'EXPO PALOMAR', plaza: 'ZMG Jalisco (Tlajomulco)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.589500, lng: -103.446200, metaPzs: 24.0, metaPesos: 113139.60, avancePzs: 0.0),
    Sucursal(codigo: '214', nombre: 'TRÁNSITO', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.696800, lng: -103.354800, metaPzs: 4.8, metaPesos: 23146.80, avancePzs: 0.0),
    Sucursal(codigo: '225', nombre: 'AMÉRICAS', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.699200, lng: -103.374500, metaPzs: 2.4, metaPesos: 60838.80, avancePzs: 1.0),
    Sucursal(codigo: '227', nombre: 'AJIJIC', plaza: 'Ajijic / Chapala', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.299500, lng: -103.263800, metaPzs: 9.6, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '235', nombre: 'PLAZA CIBELES', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.736200, lng: -103.412500, metaPzs: 1.0, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '248', nombre: '(CIRCUNVALACION)  INDEPENDENCIA', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.703500, lng: -103.329200, metaPzs: 12.0, metaPesos: 16959.60, avancePzs: 0.0),
    Sucursal(codigo: '249', nombre: 'ALLENDE', plaza: 'Mazatlán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 23.204500, lng: -106.421500, metaPzs: 2.4, metaPesos: 0.00, avancePzs: 1.0),
    Sucursal(codigo: '251', nombre: 'MERCADO DEL MAR', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.723500, lng: -103.389500, metaPzs: 6.0, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '253', nombre: 'CONTRY CLUB MOCHIS', plaza: 'Los Mochis', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 25.786500, lng: -109.004200, metaPzs: 2.4, metaPesos: 0.00, avancePzs: 1.0),
    Sucursal(codigo: '257', nombre: 'BUCERIAS', plaza: 'Bucerías / Nayarit', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.746200, lng: -105.318500, metaPzs: 13.2, metaPesos: 0.00, avancePzs: 14.0),
    Sucursal(codigo: '279', nombre: 'SAN JUAN BOSCO', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.669500, lng: -103.308200, metaPzs: 3.6, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '285', nombre: 'PLAZA SENDERA (COLIMA)', plaza: 'Colima', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.266500, lng: -103.698200, metaPzs: 2.4, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '301', nombre: 'CARRANZA (VALLARTA)', plaza: 'Puerto Vallarta', supervisorId: 'SUPER3', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.608500, lng: -105.233500, metaPzs: 4.8, metaPesos: 0.00, avancePzs: 0.0),
    Sucursal(codigo: '308', nombre: 'CD.GUZMAN CENTRO', plaza: 'Cd. Guzmán', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 19.702800, lng: -103.463500, metaPzs: 2.4, metaPesos: 48739.20, avancePzs: 0.0),
    Sucursal(codigo: '309', nombre: 'GALERIAS SANTA ANITA', plaza: 'ZMG Jalisco (Tlajomulco)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.553500, lng: -103.465800, metaPzs: 7.2, metaPesos: 22425.60, avancePzs: 2.0),
    Sucursal(codigo: '311', nombre: 'BOMBEROS TEPIC', plaza: 'Tepic', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 21.486500, lng: -104.881200, metaPzs: 7.2, metaPesos: 55868.40, avancePzs: 0.0),
    Sucursal(codigo: '312', nombre: 'PLAZA LA PERLA', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.668500, lng: -103.398200, metaPzs: 7.2, metaPesos: 31926.00, avancePzs: 2.0),
    Sucursal(codigo: '313', nombre: 'RUBEN DARIO', plaza: 'ZMG Jalisco (GDL)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.686500, lng: -103.386200, metaPzs: 3.6, metaPesos: 17137.20, avancePzs: 1.0),
    Sucursal(codigo: '314', nombre: 'GALERIAS MAZATLAN', plaza: 'Mazatlán', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 23.276200, lng: -106.449500, metaPzs: 6.0, metaPesos: 51800.40, avancePzs: 0.0),
    Sucursal(codigo: '315', nombre: 'MONTEMORELOS', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.631500, lng: -103.411200, metaPzs: 12.0, metaPesos: 5000.00, avancePzs: 1.0),
    Sucursal(codigo: '316', nombre: 'EXPO EL SALTO', plaza: 'ZMG Jalisco (El Salto)', supervisorId: 'SUPER2.JONA', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.521800, lng: -103.184500, metaPzs: 2.0, metaPesos: 3000.00, avancePzs: 1.0),
    Sucursal(codigo: '318', nombre: 'MACROPLAZA', plaza: 'Puerto Vallarta', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.639500, lng: -105.219500, metaPzs: 2.0, metaPesos: 12500.00, avancePzs: 2.0),
    Sucursal(codigo: '317', nombre: 'PLAZA ANDANZA', plaza: 'ZMG Jalisco (Zapopan)', supervisorId: 'SUPER1.ISRAEL', tipoZona: 'FORANEA', horario: '10:00-20:00', lat: 20.715500, lng: -103.412500, metaPzs: 1.0, metaPesos: 5000.00, avancePzs: 0.0),
  ];

  static final List<VisitaSupervisor> visitasSupervisor = [
    VisitaSupervisor(
      id: 'VS-101',
      supervisorId: 'SUPER1.ISRAEL',
      tipo: 'Sucursal',
      sucursalCodigo: '302',
      destinoNombre: '#302 NORMALISTAS',
      estatus: 'Cerrada',
      horaEntrada: '09:15',
      horaSalida: '10:05',
    ),
    VisitaSupervisor(
      id: 'VS-102',
      supervisorId: 'SUPER1.ISRAEL',
      tipo: 'Garantia',
      sucursalCodigo: '348',
      destinoNombre: 'Garantía Cliente • #348 PATRIA',
      folioGarantia: 'GAR-GNC-2026-089',
      dictamenGarantia: 'Procede Cambio Físico',
      fotosGarantia: [true, true, true, true, true, true],
      estatus: 'Cerrada',
      horaEntrada: '10:40',
      horaSalida: '11:20',
    ),
  ];
}

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  Usuario? currentUser;
  bool demoModeUnlocked = false;
  int simulatedDistanceMeters = 22;
  String selectedBranchCode = '302';
  bool jornadaActiva = false;
  String? horaEntradaPromotor;
  String? horaSalidaPromotor;
  int pzsVendidasHoy = 0;
  String searchBranchQuery = '';

  final TextEditingController _loginIdCtrl = TextEditingController();
  final TextEditingController _loginPassCtrl = TextEditingController();
  late final Uint8List _logoBytes;

  @override
  void initState() {
    super.initState();
    _logoBytes = base64Decode(kOfficialIconB64);
    AppData.sucursales.first.visitadaMes = true;
  }

  String _formatMoney(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return '\\$${parts[0].replaceAllMapped(reg, (m) => ',')}.00';
  }

  void _handleLogin() {
    final id = _loginIdCtrl.text.trim().toUpperCase();
    final pass = _loginPassCtrl.text.trim();
    final matches = AppData.usuarios.where((u) => u.id.toUpperCase() == id && u.pass == pass).toList();
    if (matches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales inválidas. Verifica tu usuario y contraseña asignada.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    setState(() {
      currentUser = matches.first;
      if (currentUser!.id == 'DEMO.1ADMIN') {
        demoModeUnlocked = true;
      }
      _loginPassCtrl.clear();
    });
  }

  void _quickSwitchDemo(String userId) {
    final u = AppData.usuarios.firstWhere((e) => e.id == userId);
    setState(() {
      currentUser = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F38),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(_logoBytes, width: 36, height: 36, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ColchoCheck • Super Colchones GNC',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(
                    currentUser == null
                        ? 'Acceso Seguro • Colchones América'
                        : '${currentUser!.nombre} (${currentUser!.id}) • ${currentUser!.puesto}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF93C5FD)),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (currentUser != null)
            IconButton(
              tooltip: 'Cerrar sesión',
              icon: const Icon(Icons.logout),
              onPressed: () => setState(() {
                currentUser = null;
                demoModeUnlocked = false;
              }),
            ),
        ],
      ),
      body: Column(
        children: [
          if (demoModeUnlocked && currentUser != null) _buildDemoToolbar(),
          Expanded(
            child: currentUser == null ? _buildLoginView() : _buildRoleDashboard(),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoToolbar() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('MODO DEMO.1ADMIN:',
              style: TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold)),
          ActionChip(
            label: const Text('Promotor GDL', style: TextStyle(fontSize: 11)),
            onPressed: () => _quickSwitchDemo('PROMO1.GDL'),
          ),
          ActionChip(
            label: const Text('Sup. Israel', style: TextStyle(fontSize: 11)),
            onPressed: () => _quickSwitchDemo('SUPER1.ISRAEL'),
          ),
          ActionChip(
            label: const Text('Sup. Jonathan', style: TextStyle(fontSize: 11)),
            onPressed: () => _quickSwitchDemo('SUPER2.JONA'),
          ),
          ActionChip(
            label: const Text('Ejecutivo/Admin', style: TextStyle(fontSize: 11)),
            onPressed: () => _quickSwitchDemo('VENTAS1.MOSS'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('GPS: ${simulatedDistanceMeters}m',
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              Slider(
                value: simulatedDistanceMeters.toDouble(),
                min: 10,
                max: 250,
                divisions: 12,
                onChanged: (v) => setState(() => simulatedDistanceMeters = v.round()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(_logoBytes, width: 64, height: 64, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ColchoCheck',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0B1F38))),
                            Text('Super Colchones (GNC) • América',
                                style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: const Text(
                      'Acceso corporativo protegido. Ingresa con tu usuario y contraseña asignada (sin credenciales visibles en pantalla).',
                      style: TextStyle(fontSize: 12, color: Color(0xFF1E3A8A)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _loginIdCtrl,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: 'Usuario Corporativo',
                      hintText: 'Ej. tu código de usuario asignado',
                      prefixIcon: const Icon(Icons.badge_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _loginPassCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Ingresa tu contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onSubmitted: (_) => _handleLogin(),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1F38),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _handleLogin,
                    icon: const Icon(Icons.login),
                    label: const Text('Entrar a ColchoCheck', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDashboard() {
    final rol = currentUser!.rol;
    if (rol == 'promotor') return _buildPromotorView();
    if (rol == 'supervisor') return _buildSupervisorView();
    return _buildAdminExecutiveView();
  }

  Widget _buildPromotorView() {
    final sucursal = AppData.sucursales.firstWhere(
      (b) => b.codigo == selectedBranchCode,
      orElse: () => AppData.sucursales.first,
    );
    final restantePzs = (sucursal.metaPzs - sucursal.avancePzs).clamp(0.0, 9999.0);
    final pct = sucursal.metaPzs > 0 ? ((sucursal.avancePzs / sucursal.metaPzs) * 100).clamp(0.0, 200.0) : 0.0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MI SUCURSAL EN PISO (FASE 1: SOLO PIEZAS)',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: sucursal.codigo,
                  decoration: InputDecoration(
                    labelText: 'Seleccionar Tienda (No_Tienda)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: AppData.sucursales
                      .map((b) => DropdownMenuItem(
                            value: b.codigo,
                            child: Text('#${b.codigo} ${b.nombre} (${b.plaza})'),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => selectedBranchCode = v);
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _metricBox('Meta Mensual', '${sucursal.metaPzs.toStringAsFixed(1)} pzs',
                          'Horario: ${sucursal.horario}', const Color(0xFF0B1F38)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Avance Real', '${sucursal.avancePzs.toStringAsFixed(1)} pzs',
                          'Corte: ${AppData.fechaCorteSellOut}', const Color(0xFF0F7A52)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Faltante', '${restantePzs.toStringAsFixed(1)} pzs',
                          'Cumplimiento: ${pct.toStringAsFixed(1)}%', const Color(0xFFB7791F)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('GEOCERCA GPS (100m) + EVIDENCIA EN VIVO',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 8),
                Text(
                  'Coordenadas Tienda #${sucursal.codigo}: ${sucursal.lat.toStringAsFixed(5)}, ${sucursal.lng.toStringAsFixed(5)} • Distancia actual: ${simulatedDistanceMeters}m',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: simulatedDistanceMeters <= 100 ? Colors.green.shade800 : Colors.red.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Nota operativa: El Check-in requiere estar a ≤ 100m. El Check-out permite salida normal en tienda o cierre extemporáneo hasta +2 horas después del cierre de tienda.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: jornadaActiva
                            ? null
                            : () {
                                if (simulatedDistanceMeters > 100) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Fuera de geocerca (${simulatedDistanceMeters}m > 100m). Acércate a #${sucursal.codigo} ${sucursal.nombre}.'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  jornadaActiva = true;
                                  horaEntradaPromotor = TimeOfDay.now().format(context);
                                });
                              },
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: Text(horaEntradaPromotor == null ? 'Iniciar Jornada (Check-In)' : 'Entrada: \$horaEntradaPromotor'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: !jornadaActiva
                            ? null
                            : () {
                                setState(() {
                                  jornadaActiva = false;
                                  horaSalidaPromotor = TimeOfDay.now().format(context);
                                  sucursal.avancePzs += pzsVendidasHoy;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(simulatedDistanceMeters <= 100
                                        ? 'Cierre de jornada validado en geocerca.'
                                        : 'Cierre Extemporáneo (+2h) registrado con auditoría de ubicación.'),
                                    backgroundColor: const Color(0xFF0F7A52),
                                  ),
                                );
                              },
                        icon: const Icon(Icons.verified_outlined),
                        label: const Text('Cerrar Jornada (Check-Out)'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupervisorView() {
    final supId = currentUser!.id == 'SUPER2.JONA' ? 'SUPER2.JONA' : 'SUPER1.ISRAEL';
    final misTiendas = AppData.sucursales.where((b) => b.supervisorId == supId).toList();
    final locales = misTiendas.where((b) => b.tipoZona == 'LOCAL_GDL').toList();
    final foraneas = misTiendas.where((b) => b.tipoZona == 'FORANEA').toList();
    final visitadasLocales = locales.where((b) => b.visitadaMes).length;
    final visitadasForaneas = foraneas.where((b) => b.visitadaMes).length;

    final metaPzsZona = misTiendas.fold<double>(0, (s, b) => s + b.metaPzs);
    final avancePzsZona = misTiendas.fold<double>(0, (s, b) => s + b.avancePzs);
    final metaPesosZona = misTiendas.fold<double>(0, (s, b) => s + b.metaPesos);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MINI DASHBOARD SUPERVISOR • $supId (PIEZAS + META \$ INFORMATIVA)',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _metricBox('Avance / Meta Piezas',
                          '${avancePzsZona.toStringAsFixed(1)} / ${metaPzsZona.toStringAsFixed(1)} pzs',
                          'Corte: ${AppData.fechaCorteSellOut}', const Color(0xFF0F7A52)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Meta Importe (Informativa)', _formatMoney(metaPesosZona),
                          'Cierre real sujeto a ajustes fin de mes', const Color(0xFF1D4ED8)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _metricBox('Cobertura Locales GDL', '\$visitadasLocales / ${locales.length} tiendas',
                          'Pendientes: ${locales.length - visitadasLocales}', const Color(0xFF0B1F38)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Cobertura Foráneas', '\$visitadasForaneas / ${foraneas.length} tiendas',
                          'Pendientes: ${foraneas.length - visitadasForaneas}', const Color(0xFFB7791F)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('RUTA LIBRE Y FOLIOS DE GARANTÍA (6 FOTOS)',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    FilledButton.icon(
                      onPressed: _mostrarModalNuevaGarantia,
                      icon: const Icon(Icons.verified_user_outlined, size: 18),
                      label: const Text('Nuevo Folio Garantía'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...AppData.visitasSupervisor.map((v) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: v.tipo == 'Garantia' ? Colors.amber.shade100 : Colors.blue.shade100,
                        child: Icon(v.tipo == 'Garantia' ? Icons.build_circle_outlined : Icons.storefront),
                      ),
                      title: Text('${v.destinoNombre} (${v.tipo})'),
                      subtitle: Text(v.tipo == 'Garantia'
                          ? 'Folio: ${v.folioGarantia} • Dictamen: ${v.dictamenGarantia} • 6/6 fotos'
                          : 'Entrada: ${v.horaEntrada ?? "-"} • Salida: ${v.horaSalida ?? "-"}'),
                      trailing: Chip(label: Text(v.estatus)),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _mostrarModalNuevaGarantia() {
    final folioCtrl = TextEditingController(text: 'GAR-GNC-2026-');
    String dictamen = 'Procede Cambio Físico';
    List<bool> fotos = [true, true, true, true, true, true];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => AlertDialog(
          title: const Text('Visita de Garantía (6 Fotos Cámara/Galería)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: folioCtrl,
                  decoration: const InputDecoration(labelText: 'No. Folio de Garantía'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: dictamen,
                  decoration: const InputDecoration(labelText: 'Dictamen Técnico'),
                  items: const [
                    DropdownMenuItem(value: 'Procede Cambio Físico', child: Text('Procede Cambio Físico')),
                    DropdownMenuItem(value: 'Improcedente (Mal Uso / Manchas)', child: Text('Improcedente (Mal Uso / Manchas)')),
                    DropdownMenuItem(value: 'En Revisión con Planta América', child: Text('En Revisión con Planta América')),
                  ],
                  onChanged: (v) => setModalState(() => dictamen = v!),
                ),
                const SizedBox(height: 12),
                ...List.generate(6, (idx) => CheckboxListTile(
                      dense: true,
                      value: fotos[idx],
                      title: Text(AppData.etiquetasFotosGarantia[idx], style: const TextStyle(fontSize: 12)),
                      subtitle: const Text('Cámara o Galería permitida', style: TextStyle(fontSize: 10)),
                      onChanged: (val) => setModalState(() => fotos[idx] = val ?? false),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                setState(() {
                  AppData.visitasSupervisor.insert(
                    0,
                    VisitaSupervisor(
                      id: 'VS-${DateTime.now().millisecondsSinceEpoch}',
                      supervisorId: currentUser!.id,
                      tipo: 'Garantia',
                      sucursalCodigo: selectedBranchCode,
                      destinoNombre: 'Garantía Cliente Folio ${folioCtrl.text}',
                      folioGarantia: folioCtrl.text,
                      dictamenGarantia: dictamen,
                      fotosGarantia: fotos,
                      estatus: 'Cerrada',
                      horaEntrada: TimeOfDay.now().format(context),
                      horaSalida: TimeOfDay.now().format(context),
                    ),
                  );
                });
                Navigator.pop(ctx);
              },
              child: const Text('Guardar Garantía'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminExecutiveView() {
    final totalMetaPzs = AppData.sucursales.fold<double>(0, (s, b) => s + b.metaPzs);
    final totalAvancePzs = AppData.sucursales.fold<double>(0, (s, b) => s + b.avancePzs);
    final totalMetaPesos = AppData.sucursales.fold<double>(0, (s, b) => s + b.metaPesos);
    final filtradas = AppData.sucursales
        .where((b) =>
            searchBranchQuery.isEmpty ||
            b.codigo.toLowerCase().contains(searchBranchQuery.toLowerCase()) ||
            b.nombre.toLowerCase().contains(searchBranchQuery.toLowerCase()) ||
            b.plaza.toLowerCase().contains(searchBranchQuery.toLowerCase()))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONSOLIDADO NACIONAL • CORTE SELL-OUT: ${AppData.fechaCorteSellOut}',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _metricBox('Meta Nacional Pzs', '819.8 pzs',
                          '76 Tiendas Directorio (${totalMetaPzs.toStringAsFixed(1)} pzs activas)', const Color(0xFF0B1F38)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Sell-Out Real Pzs', '97.0 pzs',
                          'En tiendas activas: ${totalAvancePzs.toStringAsFixed(1)} pzs', const Color(0xFF0F7A52)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _metricBox('Meta Importe Info', '\$3,926,265.60',
                          'Activas: ${_formatMoney(totalMetaPesos)}', const Color(0xFF1D4ED8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DIRECTORIO DE 76 SUCURSALES CON COORDENADAS GPS Y METAS (No_Tienda)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar por No_Tienda (ej. 302, 540), nombre o plaza...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (v) => setState(() => searchBranchQuery = v),
                ),
                const SizedBox(height: 10),
                ...filtradas.take(30).map((b) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text('#${b.codigo} • ${b.nombre} (${b.plaza})',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Sup: ${b.supervisorId} (${b.tipoZona}) • GPS: ${b.lat.toStringAsFixed(4)}, ${b.lng.toStringAsFixed(4)}'),
                      trailing: Text(
                        '${b.avancePzs.toStringAsFixed(0)} / ${b.metaPzs.toStringAsFixed(1)} pzs\n${_formatMoney(b.metaPesos)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _metricBox(String label, String value, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 2),
          Text(sub, style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }
}
