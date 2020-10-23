package com.unknown.hrms.utils;


import java.text.DecimalFormat ;
import java.util.ArrayList ;
import java.util.HashMap ;
import java.util.List ;
import java.util.Map ;



import org.apache.poi.ss.usermodel.Cell ;
import org.apache.poi.ss.usermodel.CellStyle ;
import org.apache.poi.ss.usermodel.DateUtil ;
import org.apache.poi.ss.usermodel.Font ;
import org.apache.poi.ss.usermodel.Row ;
import org.apache.poi.ss.usermodel.Sheet ;
import org.apache.poi.ss.usermodel.Workbook ;
import org.apache.poi.ss.util.CellRangeAddress ;


/**
 * Excel辅助类
 *
 * @version 1.0
 * @date 2013-1-18
 * @author feng.yang
 */
public class ExcelUtil {

    /**
     * excel文件的后缀 = .xls
     */
    public static final String EXCEL_FILE_SUFFIX = ".xls" ;
    /**
     * 默认的excel列宽=20
     */
    public static final int DEFAULT_COLUMN_WIDTH = 250 ;

    /**
     * 读取简单列表
     *
     * @param wsheet
     * @param startIndex
     * @param fields
     * @return
     * @see
     * @since
     */
    public List< Map< String , Object >> readSimple ( Sheet wsheet , int startIndex , String[] fields ) {
        List< Map< String , Object >> list = new ArrayList< Map< String , Object >> () ;
        for ( Row row : wsheet ) {
            // 从数据行开始读
            if ( row.getRowNum () >= startIndex ) {
                Map< String , Object > rowMap = new HashMap< String , Object > () ;
                for ( Cell cell : row ) {
                    // fields代表的列以后的数据忽略
                    if ( cell.getColumnIndex () < fields.length ) {
                        rowMap.put ( fields[cell.getColumnIndex ()] , getValue ( cell ) ) ;
                    }
                }
                list.add ( rowMap ) ;
            }
        }
        return list ;
    }

    /**
     * 得到Excel表中的值
     *
     * @param cell
     * @return
     * @see
     * @since
     */
    private Object getValue ( Cell cell ) {
        Object value = null ;
        DecimalFormat df = new DecimalFormat ( "#.####" ) ;
        switch ( cell.getCellType () ) {
            case Cell.CELL_TYPE_STRING :
                value = cell.getRichStringCellValue ().getString () ;
                break ;
            case Cell.CELL_TYPE_NUMERIC :
                if ( DateUtil.isCellDateFormatted ( cell ) ) {
                    value = CalendarHelper.formatDatetime ( cell.getDateCellValue () ) ;
                } else {
                    value = df.format ( cell.getNumericCellValue () ) ;
                }
                break ;
            case Cell.CELL_TYPE_BOOLEAN :
                value = cell.getBooleanCellValue () ;
                break ;
            case Cell.CELL_TYPE_FORMULA :
                value = cell.getCellFormula () ;
                break ;
            default :
                value = cell.getStringCellValue () ;
        }
        return value ;
    }

    /**
     * 导出简单模版的excel文件流
     * @param wwb
     * @param wsheet
     * @param parameters
     */
    public void simpleExport ( Workbook wwb , Sheet wsheet , SimpleExportParameter parameters ) {
        fillHeaders ( wwb , wsheet , parameters ) ;
        fillContent ( wwb , wsheet , parameters ) ;
    }

    private void fillHeaders ( Workbook wwb , Sheet wsheet , SimpleExportParameter parameters ) {
        wsheet.addMergedRegion ( new CellRangeAddress ( 0 , 0 , 0 , parameters.getFieldsName ().length - 1 ) ) ;
        Row titleRow = wsheet.createRow ( 0 ) ;// 标题行
        Cell titileCell = titleRow.createCell ( 0 ) ;// 合并成一个单元格
        Font titleFont = wwb.createFont () ;// 标题字体
        titleFont.setFontHeightInPoints ( ( short ) 30 ) ;
        titleFont.setFontName ( "Courier New" ) ;
        titleFont.setBoldweight ( Font.BOLDWEIGHT_BOLD ) ;
        CellStyle titileStyle = wwb.createCellStyle () ;// 标题单元格格式：居中，底对齐
        titileStyle.setAlignment ( CellStyle.ALIGN_CENTER ) ;
        titileStyle.setVerticalAlignment ( CellStyle.VERTICAL_BOTTOM ) ;
        titileStyle.setFont ( titleFont ) ;
        titileCell.setCellStyle ( titileStyle ) ;
        titileCell.setCellValue ( parameters.getTitle () ) ;
        wsheet.setDefaultColumnWidth ( 20 * DEFAULT_COLUMN_WIDTH ) ;
        for ( int i = 0 ; i < parameters.getFieldsName ().length ; ++i ) {
            if ( parameters.getWidths () != null ) {
                wsheet.setColumnWidth ( i , Integer.parseInt ( parameters.getWidths ()[i] ) * DEFAULT_COLUMN_WIDTH ) ;
            }
        }
        Font font = wwb.createFont () ;// 列标题行字体
        font.setFontHeightInPoints ( ( short ) 15 ) ;
        font.setFontName ( "Courier New" ) ;
        font.setBoldweight ( Font.BOLDWEIGHT_BOLD ) ;
        CellStyle cellStyle = wwb.createCellStyle () ;// 列标题行单元格格式：居中，底对齐
        cellStyle.setAlignment ( CellStyle.ALIGN_CENTER ) ;
        cellStyle.setVerticalAlignment ( CellStyle.VERTICAL_BOTTOM ) ;
        cellStyle.setFont ( font ) ;
        Row columnRow = wsheet.createRow ( 1 ) ;// 列标题行
        for ( int i = 0 ; i < parameters.getFieldsName ().length ; ++i ) {
            Cell cell = columnRow.createCell ( i ) ;
            cell.setCellStyle ( cellStyle ) ;
            cell.setCellValue ( parameters.getFieldsName ()[i] ) ;
        }
    }

    private void fillContent ( Workbook wwb , Sheet wsheet , SimpleExportParameter parameters ) {
        List< Map< String , Object >> list = parameters.getDataList () ;
        String value = "" ;
        String[] field = parameters.getFieldsId () ;
        for ( int i = 0 ; i < list.size () ; i++ ) {
            Row row = wsheet.createRow ( i + 2 ) ;
            for ( int j = 0 ; j < field.length ; j++ ) {
                Cell cell = row.createCell ( j ) ;
                Object origin = list.get ( i ).get ( field[j] ) ;// 原始数据
                if ( origin instanceof java.sql.Date ) {
                    java.sql.Date d = ( java.sql.Date ) origin ;
                    value = CalendarHelper.formatDatetime ( d ) ;
                } else {
                    value = String.valueOf ( origin ) ;
                }
                if ( value == null || value.equalsIgnoreCase ( "null" ) ) {
                    value = "" ;
                }
                cell.setCellValue ( value ) ;
            }
        }
    }
}

