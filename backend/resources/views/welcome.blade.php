<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asif Groceries — Fresh Groceries Delivered to Your Door in Lahore</title>
    <meta name="description" content="Order fresh produce, daily essentials, and groceries online. Fast delivery across Lahore. Download the Asif Groceries app today.">
    <meta name="theme-color" content="#F15722">
    <link rel="canonical" href="https://asifgroceries.pk">

    {{-- Open Graph --}}
    <meta property="og:title" content="Asif Groceries — Fresh Groceries Delivered">
    <meta property="og:description" content="Order fresh produce & daily essentials. Fast delivery across Lahore.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://asifgroceries.pk">

    {{-- Fonts --}}
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* ── Reset & Base ── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; -webkit-text-size-adjust: 100%; }
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #1a1a1a;
            background: #fafaf8;
            line-height: 1.6;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }
        img { display: block; max-width: 100%; }
        a { text-decoration: none; color: inherit; }

        /* ── Variables ── */
        :root {
            --orange: #F15722;
            --orange-dark: #E8471C;
            --orange-light: #FF7A47;
            --orange-glow: rgba(241, 87, 34, 0.15);
            --warm-white: #FFFBF7;
            --warm-gray: #f5f0eb;
            --text-primary: #1a1a1a;
            --text-secondary: #6b6459;
            --text-light: #9a9187;
        }

        /* ── Noise texture overlay ── */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            opacity: 0.025;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
            background-size: 256px;
            pointer-events: none;
            z-index: 9999;
        }

        /* ── Nav ── */
        .nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 100;
            padding: 1rem 2rem;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .nav.scrolled {
            background: rgba(255, 251, 247, 0.92);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow: 0 1px 0 rgba(0,0,0,0.06);
        }
        .nav-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .nav-logo {
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .nav-logo-icon {
            width: 36px;
            height: 36px;
            background: var(--orange);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
            font-size: 1.1rem;
            box-shadow: 0 2px 8px var(--orange-glow);
        }
        .nav-logo-text {
            font-weight: 700;
            font-size: 1.15rem;
            color: var(--text-primary);
        }
        .nav-links {
            display: flex;
            align-items: center;
            gap: 2rem;
            list-style: none;
        }
        .nav-links a {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-secondary);
            transition: color 0.2s;
        }
        .nav-links a:hover { color: var(--orange); }
        .nav-cta {
            background: var(--orange);
            color: white !important;
            padding: 0.55rem 1.4rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            transition: all 0.3s;
            box-shadow: 0 2px 12px var(--orange-glow);
        }
        .nav-cta:hover {
            background: var(--orange-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 20px rgba(241, 87, 34, 0.3);
        }

        /* ── Hero ── */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            background: linear-gradient(160deg, var(--warm-white) 0%, #fff 40%, var(--warm-gray) 100%);
        }
        .hero::after {
            content: '';
            position: absolute;
            top: -30%;
            right: -15%;
            width: 700px;
            height: 700px;
            background: radial-gradient(circle, var(--orange-glow) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }
        .hero-inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 8rem 2rem 4rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
            position: relative;
            z-index: 1;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--orange-glow);
            color: var(--orange-dark);
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            animation: fadeInUp 0.8s ease both;
        }
        .hero-badge-dot {
            width: 6px;
            height: 6px;
            background: var(--orange);
            border-radius: 50%;
            animation: pulse-dot 2s infinite;
        }
        .hero h1 {
            font-size: clamp(2.5rem, 5vw, 3.8rem);
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -0.03em;
            color: var(--text-primary);
            margin-bottom: 1.25rem;
            animation: fadeInUp 0.8s ease 0.1s both;
        }
        .hero h1 span {
            background: linear-gradient(135deg, var(--orange) 0%, var(--orange-light) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero-subtitle {
            font-size: 1.15rem;
            color: var(--text-secondary);
            max-width: 480px;
            line-height: 1.7;
            margin-bottom: 2.5rem;
            animation: fadeInUp 0.8s ease 0.2s both;
        }
        .hero-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: fadeInUp 0.8s ease 0.3s both;
        }
        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: var(--orange);
            color: white;
            padding: 0.9rem 2rem;
            border-radius: 14px;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            box-shadow: 0 4px 20px rgba(241, 87, 34, 0.3), inset 0 1px 0 rgba(255,255,255,0.2);
            border: none;
            cursor: pointer;
        }
        .btn-primary:hover {
            background: var(--orange-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(241, 87, 34, 0.35), inset 0 1px 0 rgba(255,255,255,0.2);
        }
        .btn-primary svg { width: 20px; height: 20px; }
        .btn-secondary {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-primary);
            padding: 0.9rem 1.5rem;
            border-radius: 14px;
            font-weight: 600;
            font-size: 1rem;
            border: 1.5px solid rgba(0,0,0,0.1);
            background: white;
            transition: all 0.3s;
            cursor: pointer;
        }
        .btn-secondary:hover {
            border-color: var(--orange);
            color: var(--orange);
            background: var(--orange-glow);
        }

        /* Hero phone mockup */
        .hero-visual {
            display: flex;
            justify-content: center;
            position: relative;
            animation: fadeInUp 0.8s ease 0.4s both;
        }
        .phone-mockup {
            width: 280px;
            height: 580px;
            background: #1a1a1a;
            border-radius: 44px;
            padding: 12px;
            box-shadow:
                0 40px 80px rgba(0,0,0,0.15),
                0 20px 40px rgba(0,0,0,0.1),
                inset 0 0 0 2px rgba(255,255,255,0.1);
            position: relative;
            transform: perspective(800px) rotateY(-8deg) rotateX(2deg);
        }
        .phone-screen {
            width: 100%;
            height: 100%;
            background: linear-gradient(180deg, var(--orange) 0%, var(--orange-dark) 35%, var(--warm-white) 35%);
            border-radius: 34px;
            overflow: hidden;
            position: relative;
        }
        .phone-notch {
            width: 120px;
            height: 28px;
            background: #1a1a1a;
            border-radius: 0 0 18px 18px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }
        .phone-header {
            padding: 1.2rem 1.5rem 2rem;
            color: white;
            text-align: left;
        }
        .phone-header-greeting {
            font-size: 0.75rem;
            opacity: 0.8;
            margin-bottom: 0.2rem;
        }
        .phone-header-title {
            font-size: 1.2rem;
            font-weight: 700;
        }
        .phone-body {
            padding: 0 1rem;
        }
        .phone-search {
            background: white;
            border-radius: 12px;
            padding: 0.7rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.75rem;
            color: var(--text-light);
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            margin-bottom: 1rem;
        }
        .phone-categories {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        .phone-cat {
            text-align: center;
            padding: 0.5rem 0.2rem;
        }
        .phone-cat-icon {
            width: 40px;
            height: 40px;
            background: var(--orange-glow);
            border-radius: 12px;
            margin: 0 auto 0.3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }
        .phone-cat-name {
            font-size: 0.6rem;
            font-weight: 600;
            color: var(--text-secondary);
        }
        .phone-section-title {
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }
        .phone-products {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.5rem;
        }
        .phone-product {
            background: white;
            border-radius: 12px;
            padding: 0.6rem;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        }
        .phone-product-img {
            height: 55px;
            background: var(--warm-gray);
            border-radius: 8px;
            margin-bottom: 0.4rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .phone-product-name {
            font-size: 0.65rem;
            font-weight: 600;
            margin-bottom: 0.15rem;
        }
        .phone-product-price {
            font-size: 0.6rem;
            color: var(--orange);
            font-weight: 700;
        }

        /* Floating badges around phone */
        .float-badge {
            position: absolute;
            background: white;
            border-radius: 16px;
            padding: 0.7rem 1.1rem;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08), 0 2px 8px rgba(0,0,0,0.04);
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 0.8rem;
            font-weight: 600;
            z-index: 3;
            animation: float 4s ease-in-out infinite;
        }
        .float-badge.top-left {
            top: 10%;
            left: -5%;
            animation-delay: 0s;
        }
        .float-badge.bottom-right {
            bottom: 15%;
            right: -8%;
            animation-delay: 2s;
        }
        .float-badge-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }
        .float-badge-icon.green { background: #e8f5e9; }
        .float-badge-icon.blue { background: #e3f2fd; }

        /* ── Features ── */
        .features {
            padding: 6rem 2rem;
            background: white;
            position: relative;
        }
        .features::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(0,0,0,0.06), transparent);
        }
        .section-inner {
            max-width: 1200px;
            margin: 0 auto;
        }
        .section-label {
            display: inline-block;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--orange);
            margin-bottom: 0.75rem;
        }
        .section-title {
            font-size: clamp(1.8rem, 3.5vw, 2.5rem);
            font-weight: 800;
            letter-spacing: -0.02em;
            line-height: 1.2;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }
        .section-desc {
            font-size: 1.05rem;
            color: var(--text-secondary);
            max-width: 540px;
            line-height: 1.7;
            margin-bottom: 3.5rem;
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }
        .feature-card {
            padding: 2rem;
            border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.05);
            background: var(--warm-white);
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.06);
            border-color: rgba(241, 87, 34, 0.15);
        }
        .feature-icon {
            width: 52px;
            height: 52px;
            background: var(--orange-glow);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1.25rem;
        }
        .feature-card h3 {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }
        .feature-card p {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.65;
        }

        /* ── How it works ── */
        .how-it-works {
            padding: 6rem 2rem;
            background: var(--warm-white);
        }
        .steps {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2.5rem;
            margin-top: 3.5rem;
        }
        .step {
            text-align: center;
            position: relative;
        }
        .step-number {
            width: 56px;
            height: 56px;
            background: var(--orange);
            color: white;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: 800;
            margin: 0 auto 1.25rem;
            box-shadow: 0 4px 16px var(--orange-glow);
        }
        .step h3 {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .step p {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.6;
            max-width: 280px;
            margin: 0 auto;
        }

        /* ── CTA ── */
        .cta-section {
            padding: 6rem 2rem;
            background: linear-gradient(135deg, var(--orange) 0%, var(--orange-dark) 100%);
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .cta-section::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
        }
        .cta-section h2 {
            font-size: clamp(2rem, 4vw, 2.8rem);
            font-weight: 800;
            color: white;
            margin-bottom: 1rem;
            letter-spacing: -0.02em;
            position: relative;
        }
        .cta-section p {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.85);
            margin-bottom: 2.5rem;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
        }
        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            position: relative;
        }
        .btn-white {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: white;
            color: var(--orange);
            padding: 0.9rem 2rem;
            border-radius: 14px;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border: none;
            cursor: pointer;
        }
        .btn-white:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }
        .btn-outline-white {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: transparent;
            color: white;
            padding: 0.9rem 2rem;
            border-radius: 14px;
            font-weight: 600;
            font-size: 1rem;
            border: 1.5px solid rgba(255,255,255,0.3);
            transition: all 0.3s;
            cursor: pointer;
        }
        .btn-outline-white:hover {
            background: rgba(255,255,255,0.1);
            border-color: rgba(255,255,255,0.5);
        }

        /* ── Footer ── */
        .footer {
            padding: 3rem 2rem;
            background: #1a1a1a;
            color: rgba(255,255,255,0.6);
        }
        .footer-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1.5rem;
        }
        .footer-brand {
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .footer-logo-icon {
            width: 32px;
            height: 32px;
            background: var(--orange);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
            font-size: 0.9rem;
        }
        .footer-brand-text {
            font-weight: 600;
            color: rgba(255,255,255,0.8);
            font-size: 0.95rem;
        }
        .footer-links {
            display: flex;
            gap: 2rem;
            list-style: none;
        }
        .footer-links a {
            font-size: 0.85rem;
            transition: color 0.2s;
        }
        .footer-links a:hover { color: var(--orange-light); }
        .footer-copy {
            font-size: 0.8rem;
            width: 100%;
            text-align: center;
            margin-top: 1rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.08);
        }

        /* ── Animations ── */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        @keyframes pulse-dot {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.4; }
        }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .hero-inner { grid-template-columns: 1fr; text-align: center; gap: 3rem; }
            .hero-subtitle { margin-left: auto; margin-right: auto; }
            .hero-actions { justify-content: center; flex-wrap: wrap; }
            .hero-visual { order: -1; }
            .phone-mockup { transform: none; width: 240px; height: 500px; }
            .float-badge { display: none; }
            .features-grid { grid-template-columns: 1fr; max-width: 480px; margin: 0 auto; }
            .steps { grid-template-columns: 1fr; max-width: 360px; margin: 3.5rem auto 0; }
            .nav-links { display: none; }
            .cta-buttons { flex-direction: column; align-items: center; }
            .footer-inner { flex-direction: column; text-align: center; }
            .footer-links { justify-content: center; }
        }

        /* ── Urdu support if needed later ── */
        [dir="rtl"] { font-family: 'Plus Jakarta Sans', 'Noto Nastaliq Urdu', sans-serif; }

        /* Mobile hamburger */
        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0.5rem;
        }
        .mobile-menu-btn span {
            display: block;
            width: 22px;
            height: 2px;
            background: var(--text-primary);
            margin: 5px 0;
            border-radius: 2px;
            transition: all 0.3s;
        }
        @media (max-width: 900px) {
            .mobile-menu-btn { display: block; }
        }
    </style>
</head>
<body>

    {{-- Navigation --}}
    <nav class="nav" id="nav">
        <div class="nav-inner">
            <a href="/" class="nav-logo">
                <div class="nav-logo-icon">AG</div>
                <span class="nav-logo-text">Asif Groceries</span>
            </a>
            <ul class="nav-links">
                <li><a href="#features">Features</a></li>
                <li><a href="#how-it-works">How It Works</a></li>
                <li><a href="{{ route('privacy-policy') }}">Privacy</a></li>
                <li><a href="#download" class="nav-cta">Download App</a></li>
            </ul>
            <button class="mobile-menu-btn" aria-label="Menu">
                <span></span><span></span><span></span>
            </button>
        </div>
    </nav>

    {{-- Hero --}}
    <section class="hero">
        <div class="hero-inner">
            <div>
                <div class="hero-badge">
                    <span class="hero-badge-dot"></span>
                    Now delivering across Lahore
                </div>
                <h1>Fresh groceries,<br><span>delivered fast.</span></h1>
                <p class="hero-subtitle">
                    Order daily essentials, fresh produce, and household items from Asif Groceries. We deliver straight to your doorstep in Lahore.
                </p>
                <div class="hero-actions">
                    <a href="#download" class="btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M17.523 2H6.477C5.768 2 5.5 2.768 5.5 3.477V20.523C5.5 21.232 5.768 22 6.477 22h11.046c.709 0 .977-.768.977-1.477V3.477C18.5 2.768 18.232 2 17.523 2zM12 20.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2zM17 17H7V4h10v13z"/></svg>
                        Get the App
                    </a>
                    <a href="#features" class="btn-secondary">
                        Learn More ↓
                    </a>
                </div>
            </div>

            <div class="hero-visual">
                <div class="float-badge top-left">
                    <div class="float-badge-icon green">🥬</div>
                    <div>
                        <div style="font-size:0.75rem;color:var(--text-light);">Fresh Veggies</div>
                        <div style="font-size:0.85rem;font-weight:700;">Just Arrived</div>
                    </div>
                </div>
                <div class="float-badge bottom-right">
                    <div class="float-badge-icon blue">🚀</div>
                    <div>
                        <div style="font-size:0.75rem;color:var(--text-light);">Delivery</div>
                        <div style="font-size:0.85rem;font-weight:700;">Fast & Reliable</div>
                    </div>
                </div>

                <div class="phone-mockup">
                    <div class="phone-screen">
                        <div class="phone-notch"></div>
                        <div class="phone-header">
                            <div class="phone-header-greeting">Good morning 👋</div>
                            <div class="phone-header-title">Asif Groceries</div>
                        </div>
                        <div class="phone-body">
                            <div class="phone-search">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
                                Search for products...
                            </div>
                            <div class="phone-categories">
                                <div class="phone-cat">
                                    <div class="phone-cat-icon">🍎</div>
                                    <div class="phone-cat-name">Fruits</div>
                                </div>
                                <div class="phone-cat">
                                    <div class="phone-cat-icon">🥕</div>
                                    <div class="phone-cat-name">Veggies</div>
                                </div>
                                <div class="phone-cat">
                                    <div class="phone-cat-icon">🥛</div>
                                    <div class="phone-cat-name">Dairy</div>
                                </div>
                                <div class="phone-cat">
                                    <div class="phone-cat-icon">🍞</div>
                                    <div class="phone-cat-name">Bakery</div>
                                </div>
                            </div>
                            <div class="phone-section-title">Popular Items</div>
                            <div class="phone-products">
                                <div class="phone-product">
                                    <div class="phone-product-img">🍅</div>
                                    <div class="phone-product-name">Fresh Tomatoes</div>
                                    <div class="phone-product-price">Rs. 120/kg</div>
                                </div>
                                <div class="phone-product">
                                    <div class="phone-product-img">🥚</div>
                                    <div class="phone-product-name">Farm Eggs</div>
                                    <div class="phone-product-price">Rs. 320/dozen</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    {{-- Features --}}
    <section class="features" id="features">
        <div class="section-inner">
            <span class="section-label">Why Choose Us</span>
            <h2 class="section-title">Everything you need,<br>delivered with care.</h2>
            <p class="section-desc">We handpick fresh produce and deliver daily essentials right to your home. Here's what makes us different.</p>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🥬</div>
                    <h3>Farm Fresh Produce</h3>
                    <p>We source directly from local farms to ensure you get the freshest fruits and vegetables every time.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Fast Delivery</h3>
                    <p>Reliable and prompt delivery to your doorstep across Lahore. Track your order in real-time.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💰</div>
                    <h3>Best Prices</h3>
                    <p>Competitive pricing on all items. No hidden fees, no surprises — just honest grocery shopping.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Easy Ordering</h3>
                    <p>Browse categories, search products, add to cart — place your order in just a few taps.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔔</div>
                    <h3>Order Updates</h3>
                    <p>Get notified at every step. From order confirmation to dispatch and delivery — stay informed.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🛡️</div>
                    <h3>Secure & Reliable</h3>
                    <p>Your data is safe with us. Sign in with Google, phone OTP, or email — hassle free.</p>
                </div>
            </div>
        </div>
    </section>

    {{-- How It Works --}}
    <section class="how-it-works" id="how-it-works">
        <div class="section-inner" style="text-align:center;">
            <span class="section-label">How It Works</span>
            <h2 class="section-title">Three simple steps to<br>fresh groceries.</h2>

            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Browse & Add</h3>
                    <p>Explore categories and search for your favourite products. Add items to your cart with one tap.</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Checkout</h3>
                    <p>Choose your delivery address, review your order, and confirm. It's quick and easy.</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Get Delivered</h3>
                    <p>Sit back and relax. Our rider will deliver your groceries fresh to your doorstep.</p>
                </div>
            </div>
        </div>
    </section>

    {{-- CTA / Download --}}
    <section class="cta-section" id="download">
        <h2>Ready to order?</h2>
        <p>Download the Asif Groceries app and start shopping for fresh groceries today.</p>
        <div class="cta-buttons">
            <a href="https://play.google.com/store/apps/details?id=com.asifgroceries.app" target="_blank" rel="noopener" class="btn-white">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M3.609 1.814 13.792 12 3.61 22.186a.996.996 0 0 1-.61-.92V2.734a1 1 0 0 1 .609-.92zm10.89 10.893 2.302 2.302-10.937 6.333 8.635-8.635zm3.199-3.199 2.302 2.302a1 1 0 0 1 0 1.38l-2.302 2.302L15.396 13l2.302-2.492zM5.864 3.658l10.937 6.333-2.302 2.302L5.864 3.658z"/></svg>
                Google Play
            </a>
            <a href="mailto:ahmadomer@zegobyte.com" class="btn-outline-white">
                Contact Us →
            </a>
        </div>
    </section>

    {{-- Footer --}}
    <footer class="footer">
        <div class="footer-inner">
            <div class="footer-brand">
                <div class="footer-logo-icon">AG</div>
                <span class="footer-brand-text">Asif Groceries</span>
            </div>
            <ul class="footer-links">
                <li><a href="{{ route('privacy-policy') }}">Privacy Policy</a></li>
                <li><a href="{{ route('delete-account') }}">Delete Account</a></li>
                <li><a href="mailto:ahmadomer@zegobyte.com">Contact</a></li>
            </ul>
            <p class="footer-copy">&copy; {{ date('Y') }} Asif Groceries. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Nav scroll effect
        const nav = document.getElementById('nav');
        window.addEventListener('scroll', () => {
            nav.classList.toggle('scrolled', window.scrollY > 40);
        });

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });
    </script>
</body>
</html>
