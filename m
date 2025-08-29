Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B755285C97
	for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475628; cv=none; b=oA9RiOvreWShQsx60nEB5Z1mtXobXR5Bf88OIkr9Bzstd/BpH8pysRx0k79o09/V81zIQ9RKGN9YW9WhGsAH2N8hkMOJxBX2mEgVmbXuHGsLtgKGLEhorI9JUSthCE9mSBGPSGmubyZILMMtNycsNRuBJDLUk9k015dxHLWnKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475628; c=relaxed/simple;
	bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtrrdulKTOuwMlviucNaddTekWgkTb0BhMMjKouVt2GbrpfHvKRCteCjZtW15q9sYlh4IL1Syh96JlpmU4MYK6VX8aScGri+/CCUXa4m+un9STiGaWUEjn+094mO+s++0N/seXio6pbeSV1FpTfOqd1X5eQ0K2Y49Nqlsa068po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJg+irNB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJg+irNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756475626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
	b=dJg+irNBktgDkEDtMPLW6EXQBnpqn15Wfvmk9DuaXC6r73AI52IQr67aNoCn9baMY7+17h
	F7+nhZ9w8hakGBlZIccjoHHzA8XpLc9is0JMhbfyLO5n/tjk7pJ+d8kkfwoIpk9V34+tDv
	Qu5YA/Z9LURdwzvHSnV1YuyDVsViUDg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-VFtRhWcUP52Bk0_m2Vvceg-1; Fri, 29 Aug 2025 09:53:44 -0400
X-MC-Unique: VFtRhWcUP52Bk0_m2Vvceg-1
X-Mimecast-MFC-AGG-ID: VFtRhWcUP52Bk0_m2Vvceg_1756475623
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-336b308ba34so5242931fa.3
        for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 06:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756475623; x=1757080423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
        b=B7+BvLfOstkT7ry1mQBUl5S/aosbh3fqcazdvIuod+EvaDY6W3MNaxtSqRgkNzvrT7
         Q+zxbVKIiqu0S4+2ULnIADlLqG13J5YB5kTGpYmXJbMuOyp/pB+XamMJyieSXnHPxRWN
         vx9BN/HLNNnyqd+aDkpc5Cx1SzOXkZw9Amt7DTRRm0n+fJwFBhHiIwd6edhsGwOuz+sb
         zu/TlC8fu/qtV19+j55GSBJ4V9Tnt17e+MMNDucUtqUk99x24wp2n9WuhGx/ADFGVWYV
         ICvwoQ5o0aFLNL41CULWdJel7/sGCDBb9M40KJB2kQwbDgHEAAOq4p28/9ten09miob9
         fd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQhSOmgXlzVdl3kdMt1Jh25MBIINgSM4vVMlJiANG78UFqPCMOZ8DxmqA2i8GROuOrJD4a@lists.linux.dev
X-Gm-Message-State: AOJu0YydVqM/f6IvPWjhRLzbEze3qXSZ2bYB7gKxp7v5kA5OOCEPmBXC
	HyaNlgOOHE1+W7wUhySKUSpjTEq87hcc8kkT/TbrJ3kAT08dP0hpeVZE4sgLpLGA0yShhAoXu3D
	xlwOOUEDxhUNkF3NgFQvyq5tv5sB/91RaqWLUsx+iBcUaTf04KTHDHMdvHPnf+bjtDdH7iN/ybU
	g8rvXeBYjmU12/ZU4rrwMftxpM7BPPow==
X-Gm-Gg: ASbGncu+bnpeQ1MOw0jwP476Th5+RURNylGQ/ZtH2bkbRyOzbPQhcbY46nimvKg/c3j
	ZYrq3Uh6rTje9+H8eYG82ThpItEQzH0qdSAe0Z7S9vOnRLE//NTiRBswszO1vP2MqLHaZwrM2EK
	J4ijreRd4Dg7sQAIkNRovvDAUp79YsoiIJz//ASs+TdmSjvf06g4T02IA=
X-Received: by 2002:a05:651c:1a0c:b0:336:a38e:486b with SMTP id 38308e7fff4ca-336a38e4e6fmr19340081fa.37.1756475623154;
        Fri, 29 Aug 2025 06:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG3EFw17S3IWQD0fjsoX++MGPxq6vbq+IqfmVOosc8Y2GEhrGtIUTfmeh6bjQcMk5h81vgu0ji4w9Vo0JiGeI=
X-Received: by 2002:a05:651c:1a0c:b0:336:a38e:486b with SMTP id
 38308e7fff4ca-336a38e4e6fmr19339981fa.37.1756475622757; Fri, 29 Aug 2025
 06:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
In-Reply-To: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 Aug 2025 09:53:30 -0400
X-Gm-Features: Ac12FXxJEwvfKiYu3k-PtLRK81E2-L6NLWxERX13IrmH1QdrSFSv6JEQyIa8v4M
Message-ID: <CAK-6q+js0y9Pnubg0ev3_GXs8Fa4KYU=nNP5r=FBatuEAUhJkw@mail.gmail.com>
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock messages
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: slzR9JZlU-MK-16zb4AkHjX214QXw2jlWFmfO25ESDU_1756475623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

What is this patch supposed to do?

Your subject states something as a fix for unlock/cancel operation.
What is the problem you encountered there?

- Alex

