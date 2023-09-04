package com.bit.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import com.bit.model.AllPaymentDTO;
import com.bit.service.AllPaymentService;
import com.bit.service.ContractService;

@RequestMapping("/excel/")
@Controller
public class ExcelController {

    private final AllPaymentService ALLPAYMENT_SERVICE;
    
    @Autowired
    public ExcelController(AllPaymentService allPaymentService, ContractService contractService) {
        this.ALLPAYMENT_SERVICE = allPaymentService;        
    }
    
    @GetMapping("download/{number}/{paymentStatus}")
    public void downloadExcel(HttpServletResponse response, 
            @PathVariable(value = "number", required = false) int number,
            @PathVariable("paymentStatus") String paymentStatus) throws IOException {
 
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("납입내역조회");
        int rowNo = 0;
        
     // 날짜를 포맷팅할 스타일과 헬퍼 생성
        CellStyle dateCellStyle = workbook.createCellStyle();
        CreationHelper creationHelper = workbook.getCreationHelper();
        dateCellStyle.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd")); // 날짜 포맷 지정
 
        Row headerRow = sheet.createRow(rowNo++);
        headerRow.createCell(0).setCellValue("증서번호");
        headerRow.createCell(1).setCellValue("고객명");
        headerRow.createCell(2).setCellValue("상품명");
        headerRow.createCell(3).setCellValue("보험료");
        headerRow.createCell(4).setCellValue("계약상태");
        headerRow.createCell(5).setCellValue("납입방법");
        headerRow.createCell(6).setCellValue("납입상태");
        headerRow.createCell(7).setCellValue("납입년월");
        headerRow.createCell(8).setCellValue("납입횟수");
        headerRow.createCell(9).setCellValue("처리일자");
 
        List<AllPaymentDTO> list = ALLPAYMENT_SERVICE.selectAllByContract(number, paymentStatus);
        for (AllPaymentDTO allpayment : list) {
            Row row = sheet.createRow(rowNo++);
            row.createCell(0).setCellValue(allpayment.getNumber());
            row.createCell(1).setCellValue(allpayment.getContractor());
            row.createCell(2).setCellValue(allpayment.getProductName());
            row.createCell(3).setCellValue(allpayment.getPremium());
            row.createCell(4).setCellValue(allpayment.getStatus());
            row.createCell(5).setCellValue(allpayment.getPaymentMethod());
            row.createCell(6).setCellValue(allpayment.getPaymentStatus());
            Cell paidDateCell = row.createCell(7);
            paidDateCell.setCellValue(allpayment.getPaidDate());
            paidDateCell.setCellStyle(dateCellStyle);
            row.createCell(8).setCellValue(allpayment.getCount());
            Cell processDateCell = row.createCell(9);
            processDateCell.setCellValue(allpayment.getProcessDate());
            processDateCell.setCellStyle(dateCellStyle);
        }
 
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=allpaymentList.xlsx");
 
        workbook.write(response.getOutputStream());
        workbook.close();
    }
}        
    
