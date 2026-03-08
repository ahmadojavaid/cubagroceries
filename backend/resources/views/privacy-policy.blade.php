<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy — Asif Groceries</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f9fafb;
            color: #1a1a1a;
            line-height: 1.7;
        }

        header {
            background: #03613D;
            padding: 24px 0;
        }

        header .inner {
            max-width: 760px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        header .logo-circle {
            width: 44px;
            height: 44px;
            background: #F5A623;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 18px;
            color: #03613D;
            flex-shrink: 0;
        }

        header h1 {
            color: #ffffff;
            font-size: 20px;
            font-weight: 700;
            letter-spacing: -0.3px;
        }

        header p {
            color: rgba(255,255,255,0.7);
            font-size: 13px;
            margin-top: 2px;
        }

        .container {
            max-width: 760px;
            margin: 48px auto;
            padding: 0 24px 80px;
        }

        .meta {
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 36px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        h2 {
            font-size: 18px;
            font-weight: 700;
            color: #03613D;
            margin: 36px 0 12px;
        }

        h2:first-of-type {
            margin-top: 0;
        }

        p {
            font-size: 15px;
            color: #374151;
            margin-bottom: 14px;
        }

        ul {
            margin: 0 0 14px 20px;
        }

        ul li {
            font-size: 15px;
            color: #374151;
            margin-bottom: 6px;
        }

        a {
            color: #03613D;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .contact-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 20px 24px;
            margin-top: 12px;
        }

        .contact-card p {
            margin: 0;
            font-size: 14px;
            color: #374151;
        }

        footer {
            text-align: center;
            font-size: 13px;
            color: #9ca3af;
            padding: 24px;
            border-top: 1px solid #e5e7eb;
        }
    </style>
</head>
<body>

<header>
    <div class="inner">
        <div class="logo-circle">AG</div>
        <div>
            <h1>Asif Groceries</h1>
            <p>Privacy Policy</p>
        </div>
    </div>
</header>

<div class="container">

    <div class="meta">
        <strong>Effective Date:</strong> {{ date('F j, Y') }}<br>
        <strong>Last Updated:</strong> {{ date('F j, Y') }}
    </div>

    <h2>1. Introduction</h2>
    <p>
        Welcome to <strong>Asif Groceries</strong> ("we", "our", or "us"). We are committed to protecting the
        personal information you share with us when using our mobile application and related services. This
        Privacy Policy explains what data we collect, how we use it, and your rights in relation to it.
    </p>
    <p>
        By using the Asif Groceries app, you agree to the practices described in this policy.
    </p>

    <h2>2. Information We Collect</h2>
    <p>We collect the following types of information:</p>
    <ul>
        <li><strong>Account Information:</strong> Your name, email address, phone number (identity), and date of birth when you register.</li>
        <li><strong>Delivery Addresses:</strong> Physical addresses you save for order delivery, including optional GPS coordinates (latitude/longitude).</li>
        <li><strong>Order Data:</strong> Details of products you purchase, order history, quantities, and payment records.</li>
        <li><strong>Wallet Activity:</strong> Your in-app wallet balance and transaction history.</li>
        <li><strong>Device Information:</strong> Device type, operating system, and app version for technical support and crash reporting.</li>
        <li><strong>Usage Data:</strong> App interactions such as screens viewed and features used, collected to improve the service.</li>
        <li><strong>Error Reports:</strong> Crash logs and error traces collected via our error monitoring system (GlitchTip) to diagnose technical issues.</li>
    </ul>

    <h2>3. How We Use Your Information</h2>
    <p>We use the information we collect to:</p>
    <ul>
        <li>Create and manage your account</li>
        <li>Process and deliver your orders</li>
        <li>Send order status updates and delivery notifications</li>
        <li>Manage your in-app wallet balance</li>
        <li>Respond to complaints and support requests</li>
        <li>Improve the performance and reliability of the app</li>
        <li>Prevent fraud and ensure security</li>
    </ul>

    <h2>4. Sharing of Information</h2>
    <p>We do <strong>not</strong> sell your personal information. We may share data only in these limited circumstances:</p>
    <ul>
        <li><strong>Delivery Personnel:</strong> Your delivery address and contact phone number are shared with the assigned delivery rider to complete your order.</li>
        <li><strong>Service Providers:</strong> We use trusted third-party services (e.g., Firebase for push notifications, error monitoring) that process data on our behalf and are bound by confidentiality obligations.</li>
        <li><strong>Legal Requirements:</strong> We may disclose information if required by applicable law or a valid legal process.</li>
    </ul>

    <h2>5. Push Notifications</h2>
    <p>
        We use Firebase Cloud Messaging (FCM) to send you push notifications about your order status. You can
        disable notifications at any time through your device's system settings. Disabling notifications will
        not affect your ability to use the app or place orders.
    </p>

    <h2>6. Data Retention</h2>
    <p>
        We retain your account and order data for as long as your account is active. If you request account
        deletion, we will remove your personal data within 30 days, except where retention is required by law
        or for legitimate business purposes such as resolving disputes.
    </p>

    <h2>7. Security</h2>
    <p>
        We implement industry-standard security measures including encrypted data transmission (HTTPS),
        hashed passwords, and secure token-based authentication. While we take reasonable precautions, no
        system is completely immune to security risks.
    </p>

    <h2>8. Children's Privacy</h2>
    <p>
        The Asif Groceries app is not directed at children under the age of 13. We do not knowingly collect
        personal information from children. If you believe a child has provided us with personal data, please
        contact us and we will delete it promptly.
    </p>

    <h2>9. Your Rights</h2>
    <p>You have the right to:</p>
    <ul>
        <li>Access the personal information we hold about you</li>
        <li>Request correction of inaccurate data</li>
        <li>Request deletion of your account and associated data</li>
        <li>Withdraw consent for non-essential data processing</li>
    </ul>
    <p>To exercise any of these rights, contact us using the details below.</p>

    <h2>10. Changes to This Policy</h2>
    <p>
        We may update this Privacy Policy from time to time. When we do, the "Last Updated" date at the top
        of this page will be revised. Continued use of the app after changes constitutes acceptance of the
        updated policy. For significant changes, we will notify you via the app.
    </p>

    <h2>11. Contact Us</h2>
    <p>If you have any questions or concerns about this Privacy Policy, please contact us:</p>
    <div class="contact-card">
        <p><strong>Asif Groceries</strong><br>
        Email: <a href="mailto:ahmadomer@zegobyte.com">ahmadomer@zegobyte.com</a><br>
        Pakistan</p>
    </div>

</div>

<footer>
    &copy; {{ date('Y') }} Asif Groceries. All rights reserved.
</footer>

</body>
</html>
