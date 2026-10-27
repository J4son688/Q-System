using System.IO;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Threading;
using PCDSQueue.Kiosk.Models;
using PCDSQueue.Kiosk.Services;
using QRCoder;
using Color = System.Windows.Media.Color;

namespace PCDSQueue.Kiosk.Views;

public partial class DepartmentQueueWindow : Window
{
    private readonly DepartmentModel _department;
    private readonly DepartmentQueueService _departmentQueueService = new();
    private readonly DispatcherTimer _refreshTimer = new()
    {
        Interval = TimeSpan.FromSeconds(3)
    };
    private bool _refreshing;
    private bool _queueOpen;
    private bool _mobileQueueEnabled = true;

    public DepartmentQueueWindow(DepartmentModel department)
    {
        InitializeComponent();
        _department = department;
        DepartmentNameText.Text = department.DepartmentName.ToUpperInvariant();
        _refreshTimer.Tick += RefreshTimer_Tick;
        Loaded += DepartmentQueueWindow_Loaded;
    }

    private async void DepartmentQueueWindow_Loaded(object sender, RoutedEventArgs e)
    {
        await RefreshDepartmentScreenAsync();
        _refreshTimer.Start();
    }

    private async Task RefreshDepartmentScreenAsync()
    {
        await CheckServerAsync();
        if (!IsServerOnline())
            return;

        if (QrImage.Source is null)
            await LoadQrAsync();
        await RefreshQueueStatusAsync();
    }

    private async Task CheckServerAsync()
    {
        var online = await ApiService.IsServerOnlineAsync();
        var color = online ? Color.FromRgb(22, 163, 106) : Color.FromRgb(220, 53, 69);
        ServerStatusDot.Fill = new SolidColorBrush(color);
        ServerStatusText.Text = online ? "Server Online" : "Server Offline";
        ServerStatusText.Foreground = new SolidColorBrush(color);
        if (!online)
        {
            QueueStateText.Text = "Server unavailable";
        }
    }

    private bool IsServerOnline() => ServerStatusText.Text == "Server Online";

    private async Task LoadQrAsync()
    {
        QrLoadingText.Visibility = Visibility.Visible;
        try
        {
            var session = await _departmentQueueService.CreateQrSessionAsync(_department.DepartmentId);
            var joinUrl = new Uri(
                ApiService.Client.BaseAddress!,
                $"join#token={Uri.EscapeDataString(session.Token)}");
            QrImage.Source = CreateQrImage(joinUrl.AbsoluteUri);
            QrLoadingText.Visibility = Visibility.Collapsed;
            ErrorText.Visibility = Visibility.Collapsed;
        }
        catch (Exception ex)
        {
            QrLoadingText.Text = "QR unavailable";
            ShowError(ex.Message);
        }
    }

    private async Task RefreshQueueStatusAsync()
    {
        if (_refreshing)
            return;

        _refreshing = true;
        try
        {
            var status = await _departmentQueueService.GetStatusAsync(_department.DepartmentId);
            WaitingCountText.Text = status.WaitingCount.ToString();
            _queueOpen = status.Department?.QueueIsOpen == true;
            _mobileQueueEnabled = status.Department?.MobileQueueEnabled ?? true;
            QueueStateText.Text = !_mobileQueueEnabled
                ? "Online queue joining is unavailable"
                : _queueOpen ? "Queue is open" : "Queue is currently closed";
            ErrorText.Visibility = Visibility.Collapsed;
        }
        catch (Exception ex)
        {
            QueueStateText.Text = "Unable to refresh queue status";
            ShowError(ex.Message);
            await CheckServerAsync();
        }
        finally
        {
            _refreshing = false;
        }
    }

    private async void RefreshTimer_Tick(object? sender, EventArgs e)
    {
        await CheckServerAsync();
        if (IsServerOnline())
        {
            if (QrImage.Source is null)
                await LoadQrAsync();
            await RefreshQueueStatusAsync();
        }
    }

    private void BackButton_Click(object sender, RoutedEventArgs e)
    {
        ReturnToHome();
    }

    private void ReturnToHome()
    {
        _refreshTimer.Stop();
        new MainWindow().Show();
        Close();
    }

    private static BitmapImage CreateQrImage(string payload)
    {
        using var generator = new QRCodeGenerator();
        using var data = generator.CreateQrCode(payload, QRCodeGenerator.ECCLevel.Q);
        var pngBytes = new PngByteQRCode(data).GetGraphic(10);
        using var stream = new MemoryStream(pngBytes);
        var image = new BitmapImage();
        image.BeginInit();
        image.CacheOption = BitmapCacheOption.OnLoad;
        image.StreamSource = stream;
        image.EndInit();
        image.Freeze();
        return image;
    }

    private void ShowError(string message)
    {
        ErrorText.Text = message;
        ErrorText.Visibility = Visibility.Visible;
    }

    protected override void OnClosed(EventArgs e)
    {
        _refreshTimer.Stop();
        base.OnClosed(e);
    }
}