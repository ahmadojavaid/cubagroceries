<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account — Asif Groceries</title>
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

        .warning-banner {
            background: #fef3c7;
            border: 1px solid #f59e0b;
            border-radius: 10px;
            padding: 16px 20px;
            margin-bottom: 36px;
            display: flex;
            gap: 12px;
            align-items: flex-start;
        }

        .warning-banner .icon {
            font-size: 20px;
            flex-shrink: 0;
            line-height: 1.4;
        }

        .warning-banner p {
            font-size: 14px;
            color: #92400e;
            margin: 0;
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

        .steps {
            list-style: none;
            margin: 0 0 14px 0;
            counter-reset: steps;
        }

        .steps li {
            counter-increment: steps;
            display: flex;
            gap: 14px;
            align-items: flex-start;
            margin-bottom: 16px;
        }

        .steps li::before {
            content: counter(steps);
            background: #03613D;
            color: #fff;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .steps li span {
            font-size: 15px;
            color: #374151;
            padding-top: 4px;
        }

        .steps li strong {
            color: #111827;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 14px;
            font-size: 14px;
        }

        .data-table th {
            background: #03613D;
            color: #fff;
            padding: 10px 14px;
            text-align: left;
            font-weight: 600;
        }

        .data-table th:first-child { border-radius: 8px 0 0 0; }
        .data-table th:last-child { border-radius: 0 8px 0 0; }

        .data-table td {
            padding: 10px 14px;
            border-bottom: 1px solid #e5e7eb;
            color: #374151;
            vertical-align: top;
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:nth-child(even) td {
            background: #f9fafb;
        }

        .badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-deleted {
            background: #fee2e2;
            color: #b91c1c;
        }

        .badge-retained {
            background: #fef3c7;
            color: #92400e;
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

        a {
            color: #03613D;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
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
            <p>Account Deletion Request</p>
        </div>
    </div>
</header>

<div class="container">

    <div class="warning-banner">
        <div class="icon">⚠️</div>
        <p><strong>This action is permanent.</strong> Once your account is deleted, your personal data and account history cannot be recovered. Please read the information below before submitting a request.</p>
    </div>

    <h2>How to Request Account Deletion</h2>
    <p>
        You can request the deletion of your Asif Groceries account and associated data by emailing us directly.
        We will process your request within <strong>30 days</strong>.
    </p>

    <ol class="steps">
        <li>
            <span>Send an email to <a href="mailto:ahmadomer@zegobyte.com">ahmadomer@zegobyte.com</a> from the email address registered to your account.</span>
        </li>
        <li>
            <span>Use the subject line: <strong>"Account Deletion Request — Asif Groceries"</strong></span>
        </li>
        <li>
            <span>Include your <strong>full name</strong> and <strong>registered phone number</strong> in the email body so we can identify your account.</span>
        </li>
        <li>
            <span>We will confirm receipt within <strong>2 business days</strong> and complete the deletion within <strong>30 days</strong> of your request.</span>
        </li>
    </ol>

    <h2>What Data Is Deleted</h2>
    <p>The table below outlines what happens to each type of data when your account is deleted.</p>

    <table class="data-table">
        <thead>
            <tr>
                <th>Data Type</th>
                <th>Action</th>
                <th>Notes</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Name, email, phone number, date of birth</td>
                <td><span class="badge badge-deleted">Deleted</span></td>
                <td>Permanently removed within 30 days</td>
            </tr>
            <tr>
                <td>Saved delivery addresses</td>
                <td><span class="badge badge-deleted">Deleted</span></td>
                <td>Permanently removed within 30 days</td>
            </tr>
            <tr>
                <td>Wallet balance</td>
                <td><span class="badge badge-deleted">Deleted</span></td>
                <td>Any remaining balance is forfeited upon deletion</td>
            </tr>
            <tr>
                <td>Order history</td>
                <td><span class="badge badge-retained">Retained</span></td>
                <td>Retained for up to 7 years for financial record-keeping and legal compliance. Personal identifiers are anonymised after 30 days.</td>
            </tr>
            <tr>
                <td>Complaints submitted</td>
                <td><span class="badge badge-retained">Retained</span></td>
                <td>Retained for up to 1 year to resolve any outstanding disputes</td>
            </tr>
            <tr>
                <td>Crash logs and error reports</td>
                <td><span class="badge badge-deleted">Deleted</span></td>
                <td>Removed from our error monitoring system within 30 days</td>
            </tr>
            <tr>
                <td>Push notification tokens</td>
                <td><span class="badge badge-deleted">Deleted</span></td>
                <td>Revoked immediately upon account deletion</td>
            </tr>
        </tbody>
    </table>

    <h2>Contact Us</h2>
    <p>If you have questions about the deletion process or your data, please reach out:</p>
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
