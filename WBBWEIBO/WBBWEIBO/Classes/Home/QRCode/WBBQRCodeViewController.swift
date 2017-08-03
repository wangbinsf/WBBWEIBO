//
//  WBBQRCodeViewController.swift
//  WBBWEIBO
//
//  Created by 王宾宾 on 2017/7/31.
//  Copyright © 2017年 王宾宾. All rights reserved.
//

import UIKit
import AVFoundation

class WBBQRCodeViewController: UIViewController {
    
    fileprivate struct qrCode {
        static let height: CGFloat = 250
        static let halfHeight = qrCode.height / 2
        static let width: CGFloat = 250
    }
    
    @IBOutlet var qrTabbar: UITabBar!
    @IBOutlet var qrcodeImageView: UIImageView!
    @IBOutlet var qrContainer: UIView!
    @IBOutlet var containerViewHeight: NSLayoutConstraint!
    @IBOutlet var moveInstance: NSLayoutConstraint!
    @IBOutlet var qrMessageInfo: UILabel!
    
    @IBAction func myMingpian(_ sender: UIButton) {
    }
    // MARK: - 懒加载
    ///输入对象
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    
    ///会话
    private lazy var session = AVCaptureSession()
    
    ///输出对象
    private lazy var output: AVCaptureMetadataOutput = {
        let out = AVCaptureMetadataOutput()
        let viewRect = self.view.frame
        let containerRect = self.qrContainer.frame
        let x = containerRect.origin.y / viewRect.height
        let y = containerRect.origin.x / viewRect.width
        let height = containerRect.width / viewRect.width
        let width = containerRect.height / viewRect.height
        
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        return out
    }()
    
    /// 预览图层
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    ///专门用于保存描边的图层
    fileprivate lazy var containerLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrTabbar.selectedItem = qrTabbar.items?.first
        qrTabbar.delegate = self
        scanQRCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(white: 0.2, alpha: 0.7)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        qrTabbar.backgroundImage = UIImage(color: UIColor(white: 0.2, alpha: 0.7))
//        qrTabbar.shadowImage = UIImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    ///关闭二维码扫描
    @IBAction func closeQR(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    ///打开相册
    @IBAction func albumQR(_ sender: UIBarButtonItem) {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
        
    }
    
    /// 开启冲击波动画
    fileprivate func startAnimation()
    {
        // 1.设置冲击波底部和容器视图顶部对齐
        moveInstance.constant = -containerViewHeight.constant
        view.layoutIfNeeded()
        
        // 2.执行扫描动画
        // 在Swift中一般情况下不用写self, 也不推荐我们写self
        // 一般情况下只有需要区分两个变量, 或者在闭包中访问外界属性才需要加上self
        // 优点可以提醒程序员主动思考当前self会不会形成循环引用
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.moveInstance.constant = self.containerViewHeight.constant
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - 内部控制方法
    fileprivate func scanQRCode()
    {
        // 1.判断输入能否添加到会话中
        if !session.canAddInput(input) {
            return
        }
        // 2.判断输出能够添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        // 3.添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        
        // 4.设置输出能够解析的数据类型
        // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // 5.设置监听监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 6.添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        // 7.添加容器图层
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        
        // 8.开始扫描
        session.startRunning()
        
    }
    

}
extension WBBQRCodeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        containerViewHeight.constant = CGFloat((item.tag == 10101) ? qrCode.height : qrCode.halfHeight)
        qrcodeImageView.image = item.tag == 10101 ? #imageLiteral(resourceName: "qrcode_scanline_qrcode") : #imageLiteral(resourceName: "qrcode_scanline_barcode")
        view.layoutIfNeeded()
        qrContainer.layer.removeAllAnimations()
        startAnimation()
    }
}
extension WBBQRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        NJLog(info)
        
        // 1.取出选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            return
        }
        
        let ciImage = CIImage(image: image)
        
        // 2.从选中的图片中读取二维码数据
        // 2.1创建一个探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        // 2.2利用探测器探测数据
        let results = detector?.features(in: ciImage!)
        // 2.3取出探测到的数据
        for result in results!
        {
            WBLog((result as! CIQRCodeFeature).messageString)
        }
        
        // 注意: 如果实现了该方法, 当选中一张图片时系统就不会自动关闭相册控制器
        picker.dismiss(animated: true, completion: nil)
    }
}
extension WBBQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        qrMessageInfo.text = (metadataObjects.last as AnyObject).stringValue
        clearSublayers()
        guard let metadata = metadataObjects.last as? AVMetadataObject else {
            return
        }
        
        ///通过预览图层将corners值转换成我们能识别的类型
        let objc = previewLayer.transformedMetadataObject(for: metadata)
        guard let codeObject = objc as? AVMetadataMachineReadableCodeObject else {
            return
        }
        ///对扫描到的二维码进行描边
        drawLines(objc: codeObject)
    }
    
    func drawLines(objc: AVMetadataMachineReadableCodeObject) {
        guard let array = objc.corners else { return }
        clearSublayers()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //path
        let path = UIBezierPath()
        var point = CGPoint.zero
        var index = 0
        
        point = CGPoint(dictionaryRepresentation: array[index] as! CFDictionary)!
        index += 1
        path.move(to: point)
        while index < array.count {
            point = CGPoint(dictionaryRepresentation: array[index] as! CFDictionary)!
            path.addLine(to: point)
            index += 1
        }
        path.close()
        shapeLayer.path = path.cgPath
        containerLayer.addSublayer(shapeLayer)
    }
    
    private func clearSublayers() {
        guard let subLayers = containerLayer.sublayers else { return }
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
}
