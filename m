Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4216FF37
	for <gfs2@lists.linux.dev>; Fri, 12 Jul 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800983; cv=none; b=V66Fpzypk8bSkUefuCv/GReXZiKc1W9b0R8qhvTEi9HZu1uKz9kKZ0HnX0Qiz0BZVmb60HYbUUG6z152nGP8iqZaCCPw95YKQazo3GHTBLS/QJC25N4A5yQCumNqiriG/T+MKhthHlA46EAEIK99ddy/mYoGOAGY10/mcCSzCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800983; c=relaxed/simple;
	bh=OfqZ//3OxReMquU8+AGgL9xNgwmaunZOL/+qPFEzY5A=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ZeZ1AL3iVUAbReJVh11UFj3PkO9HUZtdXmTWSAgyBP80J6YGdp5mrZlwywj65qo0/i08UtFRpvyBTd8fqU9q5IujsNvirOgVDnoQ5T3gpoJmunydPeN1EwIRekN+eDNrNrzg484PIEQiSTG+lLFVSSnDpj24UTtWoDjzInOBBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZZs8Lcm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZs8Lcm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af22a9c19so1742679b3a.2
        for <gfs2@lists.linux.dev>; Fri, 12 Jul 2024 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720800981; x=1721405781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OfqZ//3OxReMquU8+AGgL9xNgwmaunZOL/+qPFEzY5A=;
        b=hZZs8Lcm0WS35mjXuSI18buhH11dbyxifelcEDVxRYNKsdTMUBYKdmbUmX86obrXKH
         UdzoHCWtM3FUxuo/VpVXB0vymX5UqnfADcy8xz/P2e2hazei0s/GZdARGiOROdmlwCzu
         Vt7idRJx4lo6RlEzEhVieUJjxvpJ631rkR//8OxxjXaxH17FjeoTkdiXhLaILpzvO4vf
         KHnc3rtSRiXtHuUVt+dHw64q/Tohiee/yDApZ556FW07G7OrnFhTONf3MtNBriNhPZeK
         2nw+NWtYa7sN5zg27ZxSi7qwnlyTf/jLawtN0yvL7ZoYLPb+A10ZkbajRCiRHzMB3r5J
         7R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800981; x=1721405781;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfqZ//3OxReMquU8+AGgL9xNgwmaunZOL/+qPFEzY5A=;
        b=WzEtrGB+KXsYM7OxYsjgrbDcwSXAzTa60C7fg+zoq81bf0zc+cTO/6ffJHHJ9ktfGc
         W8aBeNF1SYkU4hGwh7W5afOvCG9Fyk0n51KuD0CN7JnT3s/VgkYZ0a9iFcmrVBYb+VQ6
         TXFxypDuN8Nc2/8QB0KV2IpR98u/2XHYNCQgolRpt/U8VO9zoBlEpyNX4sPPG6WBTjV7
         0uaYqWXSxVbJj45gsfKrET9fUh8t3BSud4dvYeFggWmP0rrpnXN533cYlJd5AxQjt/nF
         ftPQHnc3G3Qr/zfcKC1jbwbO/zwgG9NCpnxrOGx1IQ4Eb9NVUfSwv3OV8UmgOiRhESd0
         QFrg==
X-Gm-Message-State: AOJu0YzQBuwoGz5YRX3XWRfSRE53z4Nzp38whEhrpWSRdUlaAtqhYXR2
	N/LXU8y0Gasfn5p/yHFS8TVx0CS4Uo4kZntzuMK0CMJ7UsOa4LkEl/JE0Q==
X-Google-Smtp-Source: AGHT+IGvShOHQhgypQDOdVySGJSIaQBDt8g/wtDjTJaI805pazGqsbSIdGhDuRueed3MrpjC+qTNSw==
X-Received: by 2002:a05:6300:4041:b0:1c3:b26a:6d0d with SMTP id adf61e73a8af0-1c3b26a6d2emr6481956637.31.1720800981194;
        Fri, 12 Jul 2024 09:16:21 -0700 (PDT)
Received: from DESKTOP-VFHUU51 ([38.88.124.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd7027cdsm1721911a91.49.2024.07.12.09.16.20
        for <gfs2@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2024 09:16:20 -0700 (PDT)
Reply-To:  <luisfernandezconsultant@gmail.com>
From: "Luis Fernandez Consultant" <luisfernandezconsultant540@gmail.com>
To: "gfs2" <gfs2@lists.linux.dev> 
Subject: Re: Kindly Get Back To Me
Message-ID: <69630e7228dceb40ad0ac921ed03cf08@192.168.1.15>
Date: Fri, 12 Jul 2024 18:14:13 +0200
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ascii"
Content-Transfer-Encoding: quoted-printable

Good Day,=0D=0A=0D=0A=0D=0AI am Luis Fernandez from Madrid-Spain. =
I have a business opportunity that i will like to dicuss with =
you.=0D=0A=0D=0A=0D=0A=0D=0ARegards,=0D=0A=0D=0ALuis Fernandez=0D=0AMa=
drid-Spain

