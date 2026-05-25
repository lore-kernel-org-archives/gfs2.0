Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378913ED5DC
	for <gfs2@lists.linux.dev>; Mon, 25 May 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719296; cv=none; b=udNOJcGyTdpfcjt6n/vAaPFVj/Zht7L356pTGWM8q9rqAl/MVIcciljTRsPaoX+KuebEVi0oL1cTt4vHTp3YzmpW94ekXRn9WxxFUSBEV3GNIfenxIBiSJrfF5VGikfE7su2HamlkpAyJmh3+dQ6/NLE3cm3RSrHzFJaSyhZfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719296; c=relaxed/simple;
	bh=2G08YeRbLU1UmTUNiYvPRZRR9TJWmwMgsvtGVu1vOp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jt5E373A9DBz7sxMSm4nC5ODgIjgIKhzpvn5EfjJVQu/a8dzeIhbRQAUYz5AhTJflj9jE13z8Yg2Ey6L9h9RNIBf1CViLeiaK4mj2USpFqXd+7eJg5/BEU7oTRFroOSrJ344YsL/qp4ZZA8u9fP5KeF5a3L0293GkaSBjnyqPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwD8TCL3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwD8TCL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779719294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G08YeRbLU1UmTUNiYvPRZRR9TJWmwMgsvtGVu1vOp8=;
	b=OwD8TCL3lad4Mg0e5ylI4OMi1h5lDQoNX9OxEqFG9jDkVxkryRiMsk9EVEqN4/IKFuc3qN
	A4Rr0w4GHjYnY4RUfEi9NHmyk1Wcvs4R5+sTZz5NKdUya7OuYx14ogT0nl+v+9WJoxmzaE
	rRGFCaNW9wO5N7rXUQ6wk00e9jXWwQs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-qnS4OlFSMY-Q-NngSW3LTw-1; Mon, 25 May 2026 10:28:12 -0400
X-MC-Unique: qnS4OlFSMY-Q-NngSW3LTw-1
X-Mimecast-MFC-AGG-ID: qnS4OlFSMY-Q-NngSW3LTw_1779719291
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a888b0047eso6025402e87.0
        for <gfs2@lists.linux.dev>; Mon, 25 May 2026 07:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719291; x=1780324091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2G08YeRbLU1UmTUNiYvPRZRR9TJWmwMgsvtGVu1vOp8=;
        b=WNyVdOXqnver+lN3yUOSgrgCNav9LzWZcTGeGZ47ZMZqloBK8eDty5Zo39gZS81UuC
         SEzJIkG+CWh4ZsuvV36+SR5idw+6a8VLsR/0UP/k3CFxlDQp65Y3ZHlTclyMrWoBx0Ez
         to4g+ISlpXbBvRVhzCKYJtZurYkDdwzlYpZp1OPWGmGTQu5z1lWr0r0Vb13CzzFkWElQ
         yu2zMIBQ4Sj5L44NtiPdISCVxqZrUKcirkQffiBAYmv5DE8EftaSeCRkKm1fogPOk98q
         8C1c7ttO3QrBS2b7UbqjXbz032PV3OOxhKgo1xuhQXF8W09Vb6kzaAfQ9U9VRfJ34+1Y
         gHNg==
X-Forwarded-Encrypted: i=1; AFNElJ8xT3bOFyjktFvMTCvRcjmXmCi3zGUf7XjCaO2EzRZzTICwTtjtfiIuaizNsAThLXHTUl4z@lists.linux.dev
X-Gm-Message-State: AOJu0YyFxxFoSmQPDLNd1fNZs1pHYXCetI7EogSD666BfOF13wUdJS3B
	qTa/3PhQDIp6v6hFi30D7Q+itVT79VPAtf5+0eFAv6XTo7w+VbP0mbw+UWczIuv9HNBfVzjm9zT
	LDpD0On4vaeAtvtbGIhWb4NonLeDvp417t6xrMdGFMztPN7ydbZncbvVfBE0lJLtvfVELKyA20t
	YfFvXiREeFhdgNlqBOfHKHQnuWePku/A==
X-Gm-Gg: Acq92OH37s9G06AJNhArr0oelHye8SwhYrBaa5wmR9aGoG15p6U68GIzMvaXTwVxzxt
	RoCCgmqTr9INmFO7CoJQfljTEBfVNumss0/Zr/oRU580S+fLn4HlJUUwIuoSLh39DQz7qv0pi4W
	1NEV+Bbac1GhhHf3x+/PBEtOHtlMFmIylrm0ETHLcu4xtBB2UwthQxSv4zEYdLjv/wZHJb2wLJ5
	ors/CBmVHCZWml1bSgGajnPQpCHO1FcapswXqqY
X-Received: by 2002:a05:6512:3c92:b0:5a9:5a:3184 with SMTP id 2adb3069b0e04-5aa2ba62e1bmr7120999e87.1.1779719290949;
        Mon, 25 May 2026 07:28:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3c92:b0:5a9:5a:3184 with SMTP id
 2adb3069b0e04-5aa2ba62e1bmr7120983e87.1.1779719290509; Mon, 25 May 2026
 07:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
In-Reply-To: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 25 May 2026 10:27:58 -0400
X-Gm-Features: AVHnY4Jd_XDxgO4EP5KiMr9QmTC5AsHTe_y1xmRmrzFOQxqKqVmkmgA8ONMvp_c
Message-ID: <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xR93HQvmRHtuXX9Vs6g51Id9CBhywGjEvqVic31vCgk_1779719291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux.alibaba=
.com> wrote:
>
> commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which does

check with checkpath, it reports an error regarding how this commit
reference is done.

- Alex

